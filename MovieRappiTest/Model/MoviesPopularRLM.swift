//
//  MoviesRLM.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/22/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Foundation
import RealmSwift

class MoviesPopularRLM: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var vote_count: Int = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var vote_average: Double = 0.0
    @objc dynamic var title: String = ""
    @objc dynamic var populary: Double = 0.0
    @objc dynamic var poster_path: String = ""
    @objc dynamic var original_language: String = ""
    @objc dynamic var backdrop_path: String = ""
    @objc dynamic var adult: Bool = false
    @objc dynamic var overview: String = ""
    @objc dynamic var release_date: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    public func intFromResponse(response: Movies.Fetch.MovieModel) {
        let realm = try! Realm()
        for movie in response.movies! {
            let movieRLM = MoviesPopularRLM()
            movieRLM.id = movie.id!
            movieRLM.vote_count = movie.vote_count!
            movieRLM.video = movie.video!
            movieRLM.vote_average = movie.vote_average!
            movieRLM.title = movie.title!
            movieRLM.populary = movie.populary!
            movieRLM.poster_path = movie.poster_path!
            movieRLM.original_language = movie.original_language!
            movieRLM.backdrop_path = movie.backdrop_path!
            movieRLM.adult = movie.adult!
            movieRLM.overview = movie.overview!
            movieRLM.release_date = movie.release_date!

            try! realm.write {
                realm.add(movieRLM, update: true)
            }
        }
    }

    public func findMovieByID(_ ID: String) -> Results<MoviesPopularRLM> {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", ID)
        return realm.objects(MoviesPopularRLM.self).filter(predicate)
    }

    public func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }

    public func getObjects() -> [Movies.Fetch.MovieModel.Movie] {
        let realm = try! Realm()
        var moviesArray: [Movies.Fetch.MovieModel.Movie] = []
        for movies in realm.objects(MoviesPopularRLM.self) {
            moviesArray.append(Movies.Fetch.MovieModel.Movie(id: movies.id, vote_count: movies.vote_count, video: movies.video, vote_average: movies.vote_average, title: movies.title, populary: movies.populary, poster_path: movies.poster_path, original_language: movies.original_language, genre_ids: [], backdrop_path: movies.backdrop_path, adult: movies.adult, overview: movies.overview, release_date: movies.release_date))
        }
        return moviesArray
    }

    public func howManyObjectsHave() -> Int {
        let realm = try! Realm()
        let howMany = realm.objects(MoviesPopularRLM.self)
        return howMany.count
    }
}
