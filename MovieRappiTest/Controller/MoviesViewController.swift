//
//  ViewController.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/21/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import Reachability
import RealmSwift
import SCLAlertView
import UIKit

class MoviesViewController: UIViewController {
    // Realm
    var storePopularRLM = MoviesPopularRLM()
    var storeTopRankedRLM = MoviesTopRankedRLM()
    var storeUpcomingRLM = MoviesUpcomingRLM()
    // Reachability
    let reachability = Reachability()!
    // Collection View
    @IBOutlet var movieCollectionView: UICollectionView!
    var movieSelected: Movies.Fetch.MovieModel.Movie?
    var movies: [Movies.Fetch.MovieModel.Movie] = []
    // ActivityIndicator
    @IBOutlet var loadActivityIndicator: UIActivityIndicatorView!
    // UISearchBar
    var filteredMovies = [Movies.Fetch.MovieModel.Movie]()
    var filtered: [Movies.Fetch.MovieModel.Movie] = []
    var searchActive: Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet var resultsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupNavigator()
        setupSearchController()
    }

    func setupSearchController() {
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self

        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search movies", comment: "Search movies")
        searchController.searchBar.sizeToFit()

        searchController.searchBar.becomeFirstResponder()
        resultsLabel.text = NSLocalizedString("Empty List", comment: "Empty List")
        navigationItem.titleView = searchController.searchBar
    }

    func setupNavigator() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("Best Popularity", comment: "Best Popularity")
    }

    func setupTabBar() {
        let movieTabBar = UITabBar()
        movieTabBar.barTintColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.8)
        movieTabBar.frame = CGRect(x: 0, y: view.frame.size.height - 48, width: view.frame.size.width, height: 85)

        let videoPopularController = UITabBarItem()
        videoPopularController.image = UIImage(named: "popular")?.withRenderingMode(.alwaysOriginal)
        videoPopularController.selectedImage = UIImage(named: "popular_selected")?.withRenderingMode(.alwaysOriginal)
        videoPopularController.tag = 0

        let videoTopController = UITabBarItem()
        videoTopController.image = UIImage(named: "top_ranked")?.withRenderingMode(.alwaysOriginal)
        videoTopController.selectedImage = UIImage(named: "top_ranked_selected")?.withRenderingMode(.alwaysOriginal)
        videoTopController.tag = 1

        let videoUpcomingController = UITabBarItem()
        videoUpcomingController.image = UIImage(named: "upcoming")?.withRenderingMode(.alwaysOriginal)
        videoUpcomingController.selectedImage = UIImage(named: "upcoming_selected")?.withRenderingMode(.alwaysOriginal)
        videoUpcomingController.tag = 2

        movieTabBar.setItems([videoPopularController, videoTopController, videoUpcomingController], animated: true)
        view.addSubview(movieTabBar)
        movieTabBar.delegate = self
    }

    override func viewWillDisappear(_: Bool) {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    override func viewWillAppear(_: Bool) {
        setupNavigator()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            SCLAlertView().showWarning(NSLocalizedString("Important info", comment: "Important info"), subTitle: NSLocalizedString("Could not start reachability notifier", comment: "Could not start reachability notifier"))
        }
    }

    func createMoviesPopular(response: Movies.Fetch.MovieModel) {
        MoviesPopularRLM().intFromResponse(response: response)
    }

    func createMoviesTopRanked(response: Movies.Fetch.MovieModel) {
        MoviesTopRankedRLM().intFromResponse(response: response)
    }

    func createMoviesUpcoming(response: Movies.Fetch.MovieModel) {
        MoviesUpcomingRLM().intFromResponse(response: response)
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("wifi")
            getMovies()
        case .cellular:
            print("celular")
            getMovies()
        case .none:
            print("none")
            loadDataStoreRealm()
        }
    }

    func loadDataStoreRealm() {
        movies = MoviesTopRankedRLM().getObjects()
        movieCollectionView.reloadData()
        loadActivityIndicator.stopAnimating()
    }

    func getMovies() {
        getTopRankedMoviesFromService()
        getPopularRankedMoviesFromService()
        getUpcomingMoviesFromService()
    }

    func getUpcomingMoviesFromService() {
        loadActivityIndicator.startAnimating()
        DispatchQueue.main.async {
            Moviewmanager.fetchUpcoming(completion: { results, error in
                if error == nil {
                    if let results = results {
                        self.createMoviesUpcoming(response: results)
                        self.movieCollectionView.reloadData()
                    }
                } else {
                    SCLAlertView().showWarning("Warning", subTitle: error.debugDescription)
                }
                self.loadActivityIndicator.stopAnimating()
            })
        }
    }

    func getTopRankedMoviesFromService() {
        loadActivityIndicator.startAnimating()
        DispatchQueue.main.async {
            Moviewmanager.fetchTopRankedMovie(completion: { results, error in
                if error == nil {
                    if let results = results {
                        self.createMoviesTopRanked(response: results)
                        self.movieCollectionView.reloadData()
                    }
                } else {
                    SCLAlertView().showWarning("Warning", subTitle: error.debugDescription)
                }
                self.loadActivityIndicator.stopAnimating()
            })
        }
    }

    func getPopularRankedMoviesFromService() {
        loadActivityIndicator.startAnimating()
        DispatchQueue.main.async {
            Moviewmanager.fetchPopularMovie(completion: { results, error in
                if error == nil {
                    if let results = results {
                        self.createMoviesPopular(response: results)
                    }
                    self.movies = MoviesPopularRLM().getObjects()
                    self.movieCollectionView.reloadData()
                } else {
                    SCLAlertView().showWarning("Warning", subTitle: error.debugDescription)
                }
                self.loadActivityIndicator.stopAnimating()
            })
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.movie = movieSelected
    }
//    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
      
  //  }
}

extension MoviesViewController: UITabBarDelegate {
    func tabBar(_: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            title = NSLocalizedString("Best Popularity", comment: "Best Popularity")
            movies = MoviesPopularRLM().getObjects()
            movieCollectionView.reloadData()
            movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                             at: .top,
                                             animated: true)
        case 1:
            title = NSLocalizedString("Top Ranked", comment: "Top Ranked")
            movies = MoviesTopRankedRLM().getObjects()
            movieCollectionView.reloadData()
            movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                             at: .top,
                                             animated: true)
        case 2:
            title = NSLocalizedString("Upcoming", comment: "Upcoming")
            movies = MoviesUpcomingRLM().getObjects()
            movieCollectionView.reloadData()
            movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                             at: .top,
                                             animated: true)
        default:
            break
        }
    }
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieSelected = movies[indexPath.row]
        performSegue(withIdentifier: "segueDescription", sender: nil)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCollectionViewCell
        if searchActive {
            cell.movie = filtered[indexPath.item]
        } else {
            cell.movie = movies[indexPath.item]
        }
        return cell
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if searchActive {
            if filtered.count == 0 {
                resultsLabel.isHidden = false
            } else {
                resultsLabel.isHidden = true
            }
            return filtered.count
        } else {
            if movies.count == 0 {
                resultsLabel.isHidden = false
            } else {
                resultsLabel.isHidden = true
            }
            return movies.count
        }
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 350.0)
    }

    func collectionView(_: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt _: IndexPath) {
        // Animations for cell collection
        cell.alpha = 0
        cell.frame.origin.x = 500
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
            cell.frame.origin.x = 0
        }
    }
}

extension MoviesViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarCancelButtonClicked(_: UISearchBar) {
        searchActive = false
        dismiss(animated: true, completion: nil)
    }

    func updateSearchResults(for searchController: UISearchController) {
        filtered = movies.filter { (movie) -> Bool in
            if let title = movie.title{
                let movies: String = title as String
                if movies.lowercased().contains(self.searchController.searchBar.text!.lowercased()) {
                    return true
                } else {
                    return false
                }
            }
          return false
        }

        movieCollectionView.reloadData()
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        searchActive = true
        movieCollectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_: UISearchBar) {
        searchActive = false
        movieCollectionView.reloadData()
    }

    func searchBarBookmarkButtonClicked(_: UISearchBar) {
        if !searchActive {
            searchActive = true
            movieCollectionView.reloadData()
        }

        searchController.searchBar.resignFirstResponder()
    }
}
