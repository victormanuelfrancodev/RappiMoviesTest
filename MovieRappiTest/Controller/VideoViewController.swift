//
//  VideoViewController.swift
//  MovieRappiTest
//
//  Created by Victor Manuel Lagunas Franco on 5/26/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import UIKit
import WebKit
import AVKit

class VideoViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var webView: WKWebView!
    var videoID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let videoID = videoID {
            loadYoutube(videoID: videoID)
        }
    }
    
    //MARK:- Play Video
    
    func loadYoutube(videoID:String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)") else {
            return
        }
        webView.load(URLRequest(url: youtubeURL))
        webView.addSubview(loadActivityIndicator)
        loadActivityIndicator.startAnimating()
        webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadActivityIndicator.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadActivityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
        loadActivityIndicator.stopAnimating()
    }
}
