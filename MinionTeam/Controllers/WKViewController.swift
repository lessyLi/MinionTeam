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
    
    let session = Session.instance
    let serviceVK = ServiceVK()
    var friendsData = [Friend]()
    var tokenString: String = "" {
        didSet {
            session.token = tokenString
            performSegue(withIdentifier: "webViewToLoginSegue", sender: nil)
        }
    }
    var userID: Int = 0 {
        didSet {
            session.myID = userID
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.load(serviceVK.autorisationVK())
        print("autorisationVK")
    }
    
}

    //сега ж не сработает с этого экрана.

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
        let userID = params["user_id"]

            // Session.instance.token = token ?? ""
        print(token!)
        print(userID!)
        tokenString = token!
        self.userID = Int(userID!)!
            //    serviceVK.loadVKData(load: .friends) { [weak self] friendsData in
        //    self?.friendsData = friendsData
//            webView.reload()
     //   }
        
//        WeatherService().loadWeatherData(city: "Moscow") { [weak self] weatherArray in
//            self?.weatherData = weatherArray
//            DispatchQueue.main.async {
//                self?.collectionView.reloadData()
//            }
//        }
        
//        webview.load(serviceVK.getFriendsVK())
//        webview.load(serviceVK.getPhotosVK())
//        webview.load(serviceVK.getGroupsVK())
//        webview.load(serviceVK.getSearchGroupsVK())
        
        decisionHandler(.cancel)
    }
}

