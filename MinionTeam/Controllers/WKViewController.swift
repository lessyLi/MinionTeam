//
//  WKViewController.swift
//  MinionTeam
//
//  Created by MacBook on 14.06.2022.
//

import UIKit
import WebKit
import Alamofire

class WKViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }

    let serviceVK = ServiceVK()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            webview.load(serviceVK.autorisationVK())
    }
    
}

extension WKViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        let token = params["access_token"]

        Session.instance.token = token ?? ""
        
        webview.load(serviceVK.getFriendsVK())
//        webview.load(serviceVK.getPhotosVK())
//        webview.load(serviceVK.getGroupsVK())
//        webview.load(serviceVK.getSearchGroupsVK())
        
        decisionHandler(.cancel)
    }
}

