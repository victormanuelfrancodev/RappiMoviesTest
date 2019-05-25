//
//  MovieManager.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/22/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class Moviewmanager {
    class func fetchPopularMovie(completion: @escaping (Movies.Fetch.MovieModel?, Error?) -> Void) {
        let request = APIRequest.getListMoviePopular()
        request.send().responseJSON(completionHandler: {
            response in
            parseResponse(response: response, completion: completion)
        })
    }

    class func fetchTopRankedMovie(completion: @escaping (Movies.Fetch.MovieModel?, Error?) -> Void) {
        let request = APIRequest.getListTopRanked()

        request.send().responseJSON(completionHandler: {
            response in
            parseResponse(response: response, completion: completion)
        })
    }

    class func fetchUpcoming(completion: @escaping (Movies.Fetch.MovieModel?, Error?) -> Void) {
        let request = APIRequest.getListUpcoming()

        request.send().responseJSON(completionHandler: {
            response in
            parseResponse(response: response, completion: completion)
        })
    }

    private class func parseResponse(response: DataResponse<Any>, completion: @escaping (Movies.Fetch.MovieModel?, Error?) -> Void) {
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

    private class func parseResultsJSON(json: JSON) -> Movies.Fetch.MovieModel {
        let movieModel = Movies.Fetch.MovieModel(json: json)
        return movieModel
    }
}
