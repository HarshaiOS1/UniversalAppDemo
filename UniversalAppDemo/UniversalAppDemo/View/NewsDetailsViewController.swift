//
//  NewsDetailsViewController.swift
//  UniversalAppDemo
//
//  Created by Harsha on 23/04/2023.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var webview: WKWebView!
    
    var newsURL: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        webview.uiDelegate = self
        webview.navigationDelegate = self
        if let url = NSURL(string: newsURL) {
            DispatchQueue.main.async {
                self.webview.load(URLRequest.init(url: url as URL))
            }
        }
    }
}

extension NewsDetailsViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        ToastView(message: "Error loading webpage").show()
        self.dismiss(animated: true)
    }
}
