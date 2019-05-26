//
//  VideoManager.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/26/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class VideoManager {
    class func fetchVideos(request: Videos.Fetch.Request, completion: @escaping (Videos.Fetch.VideoModel?, Error?) -> Void) {
        let request = APIRequest.getListVideos(idMovie: request.idMovie)

        request.send().responseJSON(completionHandler: {
            response in
            parseResponse(response: response, completion: completion)
        })
    }

    private class func parseResponse(response: DataResponse<Any>, completion: @escaping (Videos.Fetch.VideoModel?, Error?) -> Void) {
        guard response.result.error == nil else {
            completion(nil, response.result.error)
            return
        }
        guard let value = response.result.value else {
            completion(nil, RequestError.noData)
            return
        }
        do {
            let json = JSON(value)
            try parseResponseJSON(json: json)
            let results = parseResultsJSON(json: json)
            completion(results, nil)
        } catch {
            completion(nil, error)
        }
    }

    private class func parseResponseJSON(json: JSON) throws {
        let data = json["results"]
        guard data.exists() else {
            let errors = json["errors"]
            if errors.exists() {
                throw JSONResponseError.serverError(message: errors[0].string ?? "No error message")
            } else {
                throw JSONResponseError.missingParameter(parameter: "data")
            }
        }
    }

    private class func parseResultsJSON(json: JSON) -> Videos.Fetch.VideoModel {
        let videoModel = Videos.Fetch.VideoModel(json: json)
        return videoModel
    }
}
