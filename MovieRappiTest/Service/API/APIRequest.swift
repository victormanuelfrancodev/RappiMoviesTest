//
import Alamofire
//  APIRequest.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/21/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//
import Foundation
import SCLAlertView

struct APIRequest {
    // Production
    static let baseURL = "https://api.themoviedb.org/"

    static let api_key = "2b6ef75c27b8c44c0d5e8c0c05db49ee"
    static let language:String = Locale.preferredLanguageIdentifier
    static let version_api_movies = "3"
    static let apiURL = baseURL

    var url: String?
    var method: HTTPMethod?
    var params: Parameters?
    var encoding: ParameterEncoding?
    var headers: HTTPHeaders?
    

    init(_ url: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.httpBody,
         headers: HTTPHeaders? = nil) {
        self.url = url
        self.method = method
        params = parameters
        self.encoding = encoding
        self.headers = headers
    }

    init() {}

    // MARK: - request

    func send() -> Alamofire.DataRequest {
        return Alamofire.request(url!, method: method!, parameters: params, encoding: encoding!, headers: headers)
    }

    func cancelAllRequests() {
        SCLAlertView().showWarning("Warning", subTitle: "cancelling NetworkHelper requests")
    }

    // Get a fetch of the popular movies
    /// Movie/popular  Locale.preferredLanguageIdentifier
    static func getListMoviePopular() -> APIRequest {
        return APIRequest(apiURL + "\(version_api_movies)/movie/popular?" + "api_key=\(api_key)" + "&language=\(language)&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default)
    }

    // Get a fetch of the top ranked movies
    // Movie/topRanked
    static func getListTopRanked() -> APIRequest {
        return APIRequest(apiURL + "\(version_api_movies)/movie/top_rated?" + "api_key=\(api_key)" + "&language=\(language)&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default)
    }

    // Get a fetch of the upcoming movies
    // Movie/topRanked

    static func getListUpcoming() -> APIRequest {
        return APIRequest(apiURL + "\(version_api_movies)/movie/upcoming?" + "api_key=\(api_key)" + "&language=\(language)&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default)
    }
}
