//
//  MoviesModel.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/22/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import SwiftyJSON
import UIKit

enum Movies {
    enum Fetch {
        struct Request {}

        struct Response {
            var movies: [MovieModel.Movie]?
            var isError: Bool
            var message: String?
        }

        struct MovieModel {
            init(json: JSON) {
                movies = []

                let json = json["results"]
                for movieJSON in json.array! {
                    let matchModel = Movie(json: movieJSON)
                    movies?.append(matchModel)
                }
            }

            enum KindOfMovie: String {
                case TopRanked = "Top Ranked"
                case Upcoming
                case PopularMovie = "Popular Movie"
            }

            struct Movie {
                var id: Int?
                var vote_count: Int?
                var video: Bool?
                var vote_average: Double?
                var title: String?
                var populary: Double?
                var poster_path: String?
                var original_language: String?
                var genre_ids: [Genre]?
                var backdrop_path: String?
                var adult: Bool?
                var overview: String?
                var release_date: String?

                init(id: Int, vote_count: Int, video: Bool, vote_average: Double, title: String, populary: Double, poster_path: String, original_language: String, genre_ids: [Genre], backdrop_path: String, adult: Bool, overview: String, release_date: String) {
                    self.id = id
                    self.vote_count = vote_count
                    self.video = video
                    self.vote_average = vote_average
                    self.title = title
                    self.populary = populary
                    self.poster_path = poster_path
                    self.original_language = original_language
                    self.genre_ids = genre_ids
                    self.backdrop_path = backdrop_path
                    self.adult = adult
                    self.overview = overview
                    self.release_date = release_date
                }

                init(json: JSON) {
                    id = json["id"].intValue
                    vote_count = json["vote_count"].intValue
                    video = json["video"].boolValue
                    vote_average = json["vote_average"].doubleValue
                    title = json["title"].stringValue
                    populary = json["popularity"].doubleValue
                    poster_path = "https://image.tmdb.org/t/p/w500" + json["poster_path"].stringValue
                    original_language = json["original_language"].stringValue
                    genre_ids = json["genre_ids"].arrayObject as? [Genre]
                    backdrop_path = "https://image.tmdb.org/t/p/w500" + json["backdrop_path"].stringValue
                    adult = json["adult"].boolValue
                    overview = json["overview"].stringValue
                    release_date = json["release_date"].stringValue
                }

                init() {}
            }

            var movies: [Movie]?
        }

        struct ViewModel {
            var movies: [MovieModel.Movie]?
            var isError: Bool = false
            var message: String?
            init() {}
            init(response: Fetch.Response) {
                if let moviesTmp = response.movies {
                    movies = moviesTmp
                }

                isError = response.isError
                message = response.message
            }
        }
    }
}
