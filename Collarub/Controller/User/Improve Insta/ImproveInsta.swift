//
//  ImproveInsta.swift
//  Collarub
//
//  Created by apple on 19/04/2019.
//  Copyright © 2019 Mac 1. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation
import ARKit
class ImproveInsta:  UIViewController, WKNavigationDelegate{

    //@IBOutlet weak var webView: WKWebView!
    var webView: WKWebView!

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//        self.view.addSubview(webView)
//
//        let url = URL(string: "https://influencerskings.com")
//
//        webView.load(URLRequest(url: url!))
//    }
//
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        let url = URL(string: "https://influencerskings.com")!
        webView.load(URLRequest(url: url))

        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

  

}
