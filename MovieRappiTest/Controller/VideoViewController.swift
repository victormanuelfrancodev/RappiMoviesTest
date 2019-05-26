//
//  VideoViewController.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/26/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import AVKit
import UIKit
import WebKit

class VideoViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var loadActivityIndicator: UIActivityIndicatorView!

    @IBOutlet var webView: WKWebView!
    var videoID: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let videoID = videoID {
            loadYoutube(videoID: videoID)
        }
    }

    // MARK: - Play Video

    func loadYoutube(videoID: String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)") else {
            return
        }
        webView.load(URLRequest(url: youtubeURL))
        webView.addSubview(loadActivityIndicator)
        loadActivityIndicator.startAnimating()
        webView.navigationDelegate = self
    }

    func webView(_: WKWebView, didCommit _: WKNavigation!) {
        loadActivityIndicator.startAnimating()
    }

    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        loadActivityIndicator.stopAnimating()
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError error: Error) {
        print(error)
        loadActivityIndicator.stopAnimating()
    }
}
