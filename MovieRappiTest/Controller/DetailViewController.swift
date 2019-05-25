//
//  DetailViewController.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/25/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Cosmos
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var movieUIImageView: UIImageView!
    var movie: Movies.Fetch.MovieModel.Movie?
    @IBOutlet var descrriptionTextView: UITextView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbMovieImageView: UIImageView!
    @IBOutlet var rateCosmos: CosmosView!
    @IBOutlet var ratingLabel: UILabel!

    @IBOutlet var languageLabel: UILabel!

    @IBOutlet var adultMovieImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigator()
        // Do any additional setup after loading the view.
        setupData()
    }

    func setupData() {
        if let movie = movie, let poster_path = movie.poster_path {
            movieUIImageView.cacheImage(imageUrlString: poster_path)
            thumbMovieImageView.cacheImage(imageUrlString: poster_path)
            if let overview = movie.overview {
                descrriptionTextView.text = overview
            }
            if let title = movie.title {
                titleLabel.text = title
            }
            if let date = movie.release_date {
                dateLabel.text = date
            }
            if let vote_average = movie.vote_average {
                rateCosmos.rating = vote_average * 5 / 10
                ratingLabel.text = String(vote_average)
            }
            if let language = movie.original_language {
                languageLabel.text = NSLocalizedString("Language", comment: "Language") + ": " + language
            }
            if let adultMovie = movie.adult {
                if adultMovie {
                    adultMovieImageView.isHidden = false
                } else {
                    adultMovieImageView.isHidden = true
                }
            }
        }
    }

    func setupNavigator() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
