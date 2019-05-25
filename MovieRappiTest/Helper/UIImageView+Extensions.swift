//
//  UIImageView+Extensions.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/23/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    static let imageCache = NSCache<AnyObject, AnyObject>()

    func cacheImage(imageUrlString: String) {
        let url = URL(string: imageUrlString)
        if let imageFromCache = UIImageView.imageCache.object(forKey: imageUrlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url!) { data, _, error in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)

                self.image = imageToCache
                UIImageView.imageCache.setObject(imageToCache!, forKey: imageUrlString as AnyObject)
            }
        }.resume()
    }

    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }

    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
