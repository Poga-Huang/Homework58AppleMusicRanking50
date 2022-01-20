//
//  WebViewController.swift
//  Homework58AppleMusicRanking50
//
//  Created by 黃柏嘉 on 2022/1/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    
    
    var urlString:String
    init?(coder:NSCoder,urlString:String){
        self.urlString = urlString
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: urlString) else{return}
        let urlRequest = URLRequest(url: url)
        myWebView.load(urlRequest)
        
        myWebView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingActivityIndicator.stopAnimating()
    }
   

}
