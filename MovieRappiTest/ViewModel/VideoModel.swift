//
//  VideoModel.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/26/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import SwiftyJSON

enum Videos {
    enum Fetch {
        struct Request {
            let idMovie: String
        }

        struct Response {
            var videos: [VideoModel.Video]?
            var isError: Bool
            var message: String?
        }

        struct VideoModel {
            init(json: JSON) {
                videos = []

                let json = json["results"]
                for videoJSON in json.array! {
                    let matchModel = Video(json: videoJSON)
                    videos?.append(matchModel)
                }
            }

            struct Video {
                var id: String?
                var iso_639_1: String?
                var iso_3166_1: String?
                var key: String?
                var name: String?
                var site: String?
                var size: Int?
                var type: String?

                init(id: String, iso_639_1: String, iso_3166_1: String, key: String, name: String, site: String, size: Int, type: String) {
                    self.id = id
                    self.iso_639_1 = iso_639_1
                    self.iso_3166_1 = iso_3166_1
                    self.key = key
                    self.name = name
                    self.site = site
                    self.size = size
                    self.type = type
                }

                init(json: JSON) {
                    id = json["id"].stringValue
                    iso_639_1 = json["iso_639_1"].stringValue
                    iso_3166_1 = json["iso_3166_1"].stringValue
                    key = json["key"].stringValue
                    name = json["title"].stringValue
                    site = json["site"].stringValue
                    size = json["size"].intValue
                    type = json["type"].stringValue
                }

                init() {}
            }

            var videos: [Video]?
        }

        struct ViewModel {
            var videos: [VideoModel.Video]?
            var isError: Bool = false
            var message: String?
            init() {}
            init(response: Fetch.Response) {
                if let videosTmp = response.videos {
                    videos = videosTmp
                }

                isError = response.isError
                message = response.message
            }
        }
    }
}
