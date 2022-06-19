//
//  WebViewController.swift
//  Homework58AppleMusicRanking50
//
//  Created by 黃柏嘉 on 2022/1/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    
    
    var urlString:String?
   
    

    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = urlString,let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            myWebView.load(urlRequest)
        }
        myWebView.navigationDelegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        urlString = ""
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingActivityIndicator.stopAnimating()
    }
   

}
