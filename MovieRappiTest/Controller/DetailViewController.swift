//
//  DetailViewController.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/25/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Cosmos
import Hero
import Reachability
import SCLAlertView
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
    // Reachability
    let reachability = Reachability()!
    // Video
    var videos: [Videos.Fetch.VideoModel.Video] = []
    @IBOutlet weak var loadActivittyIndicator: UIActivityIndicatorView!
    var videoKey:String?
    
    @IBOutlet weak var playVideoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigator()
        // Do any additional setup after loading the view.
        setupData()
    }

    func setupData() {
        if let movie = movie, let poster_path = movie.poster_path {
            movieUIImageView.cacheImage(imageUrlString: poster_path)
            movieUIImageView.hero.id = poster_path
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

    override func viewWillAppear(_: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            SCLAlertView().showWarning(NSLocalizedString("Important info", comment: "Important info"), subTitle: NSLocalizedString("Could not start reachability notifier", comment: "Could not start reachability notifier"))
        }

        languageLabel.alpha = 0
        dateLabel.alpha = 0
        ratingLabel.alpha = 0
        rateCosmos.alpha = 0
        titleLabel.alpha = 0
        descrriptionTextView.alpha = 0
        descriptionLabel.alpha = 0
        thumbMovieImageView.alpha = 0
    }

    override func viewDidAppear(_: Bool) {
        titleLabel.frame.origin.x = 700
        dateLabel.frame.origin.x = 650
        rateCosmos.frame.origin.x = 600
        ratingLabel.frame.origin.x = 550
        languageLabel.frame.origin.x = 500

        descrriptionTextView.frame.origin.y = 1200
        descriptionLabel.frame.origin.y = 1000

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

        UIView.animate(withDuration: 0.8) {
            self.descrriptionTextView.frame.origin.y = 20
            self.descrriptionTextView.alpha = 1
            self.descriptionLabel.frame.origin.y = 0
            self.descriptionLabel.alpha = 1
        }
    }

    override func viewWillDisappear(_: Bool) {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    func getVideos() {
        loadActivittyIndicator.startAnimating()
        DispatchQueue.main.async {
            if let id = self.movie?.id {
                let request = Videos.Fetch.Request(idMovie: String(id))
                print(String(id))
                VideoManager.fetchVideos(request: request, completion: { results, error in
                    if error == nil {
                        if let results = results {
                            if let videos = results.videos {
                                for r in videos {
                                    self.videos.append(r)
                                }
                            }
                        }
                    } else {
                        SCLAlertView().showWarning("Warning", subTitle: error.debugDescription)
                    }
                    if !self.videos.isEmpty{
                        self.videoKey = self.videos[0].key
                    }else{
                          SCLAlertView().showWarning(NSLocalizedString("Important info", comment: "Important info"), subTitle: NSLocalizedString("Possibly we don't have video for this movie", comment: "Possibly we don't have video for this movie"))
                        self.playVideoButton.isHidden = true
                    }
                     self.loadActivittyIndicator.stopAnimating()
                })
            }
        }
    }
    @IBAction func buttonPlayVideoAction(_ sender: Any) {
        performSegue(withIdentifier:"SegueVideo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let video = videoKey{
            DispatchQueue.main.async {
                let videoVC = segue.destination as! VideoViewController
                videoVC.videoID = video
            }
        }else{
             SCLAlertView().showWarning(NSLocalizedString("Important info", comment: "Important info"), subTitle: NSLocalizedString("There was an error loading the video", comment: "There was an error loading the video"))
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("wifi")
            getVideos()
            playVideoButton.isHidden = false
        case .cellular:
            print("celular")
            getVideos()
            playVideoButton.isHidden = false
        case .none:
            print("none")
            playVideoButton.isHidden = true
            
        }
    }
}
