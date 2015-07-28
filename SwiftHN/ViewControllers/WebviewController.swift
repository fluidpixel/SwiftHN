//
//  WebviewController.swift
//  SwiftHN
//
//  Created by Thomas Ricouard on 05/06/14.
//  Copyright (c) 2014 Thomas Ricouard. All rights reserved.
//

import UIKit
import HackerSwifter

class WebviewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView : UIWebView! = nil
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    
    var post: Post!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        if let realpost = self.post {
            if let realUrl = self.post.url {
                self.webView.loadRequest(NSURLRequest(URL: realUrl))
            }
        }
    }
    
    func setupLoadingButton() {
        self.navigationItem.rightBarButtonItem = nil
        let loadingItem = UIBarButtonItem(customView: self.activityIndicator)
        self.activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = loadingItem
    }
    
    func setupShareButton() {
        self.navigationItem.rightBarButtonItem = nil
        let shareItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "onShareButton")
        let commentsButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Organize, target: self, action: "onCommentButton")
        self.navigationItem.rightBarButtonItems = [shareItem, commentsButton]
        
    }
    
    func onShareButton() {
        Helper.showShareSheet(self.post, controller: self, barbutton: self.navigationItem.rightBarButtonItem)
    }
    
    func onCommentButton() {
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailVC.post = post
        self.showDetailViewController(detailVC, sender: self)
        
//        performSegueWithIdentifier("commentSegue", sender: self)
    }

    func webViewDidStartLoad(webView: UIWebView) {
        self.setupShareButton()
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
//        self.setupShareButton()
        self.title = webView.stringByEvaluatingJavaScriptFromString("document.title")
    }
}
