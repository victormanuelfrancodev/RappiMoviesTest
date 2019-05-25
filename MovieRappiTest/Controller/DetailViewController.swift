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

    override func viewWillAppear(_ animated: Bool) {
        self.languageLabel.alpha = 0
        self.dateLabel.alpha = 0
        self.ratingLabel.alpha = 0
        self.rateCosmos.alpha = 0
        self.titleLabel.alpha = 0
        self.descrriptionTextView.alpha = 0
        self.descriptionLabel.alpha = 0
        self.thumbMovieImageView.alpha = 0
    }
    override func viewDidAppear(_ animated: Bool) {
         self.titleLabel.frame.origin.x = 700
         self.dateLabel.frame.origin.x = 650
         self.rateCosmos.frame.origin.x = 600
         self.ratingLabel.frame.origin.x = 550
         self.languageLabel.frame.origin.x = 500
        
         self.descrriptionTextView.frame.origin.y = 1200
         self.descriptionLabel.frame.origin.y = 1000
      
        UIView.animate(withDuration: 0.5) {
            self.languageLabel.frame.origin.x = 0
            self.languageLabel.alpha = 1
            self.ratingLabel.frame.origin.x = 0
            self.ratingLabel.alpha = 1
            self.rateCosmos.frame.origin.x = 0
            self.rateCosmos.alpha = 1
            self.dateLabel.frame.origin.x = 0
            self.dateLabel.alpha = 1
            self.titleLabel.frame.origin.x = 0
            self.titleLabel.alpha = 1
            self.thumbMovieImageView.alpha = 1
        }
        
        UIView.animate(withDuration: 0.8){
            self.descrriptionTextView.frame.origin.y = 20
            self.descrriptionTextView.alpha = 1
            self.descriptionLabel.frame.origin.y = 0
            self.descriptionLabel.alpha = 1
        }
        
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
