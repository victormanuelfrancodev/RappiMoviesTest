//
//  MovieCollectionViewCell.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/23/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Cosmos
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet var container: UIView!
    @IBOutlet var titleMovieLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var centerViewImagen: NSLayoutConstraint!
    @IBOutlet var starsCosmos: CosmosView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!

    var parallaxOffset: CGFloat = 0 {
        didSet {
            centerViewImagen.constant = parallaxOffset
        }
    }

    var movie: Movies.Fetch.MovieModel.Movie? {
        didSet {
            if let movie = movie {
                titleMovieLabel.text = movie.title
                if let poster_path = movie.poster_path {
                    movieImageView.cacheImage(imageUrlString: poster_path)
                }
                if let vote_average = movie.vote_average {
                    starsCosmos.rating = vote_average * 5 / 10
                    ratingLabel.text = String(vote_average)
                }
                if let populary = movie.populary {
                    viewsLabel.text = NSLocalizedString("Popularity", comment: "Popularity") + ": " + String(populary)
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    }
}
