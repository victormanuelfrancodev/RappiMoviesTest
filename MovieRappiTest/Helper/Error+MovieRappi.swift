//
//  Error+MovieRappi.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/22/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Foundation

enum DefaultError: Error {
    case unknownError
}

/**
 Custom error generated when request does not return data
 */
enum RequestError: Error {
    case noData
    case noHeaders
    case missingHeaderParameter(parameter: String)
}

/**
 Error in JSON server response

 Not in the JSON data itself!
 */
enum JSONResponseError: Error {
    case missingParameter(parameter: String)
    case serverError(message: String)
}

/**
 Custom error generated when JSON parsing fails
 */
enum JSONError: Error {
    case parserMissingParameter(parameter: String) // expected parameter not part of parsed JSON
}
