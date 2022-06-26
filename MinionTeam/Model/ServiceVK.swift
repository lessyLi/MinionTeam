//
//  ServiceVK.swift
//  MinionTeam
//
//  Created by MacBook on 16.06.2022.
//

import Foundation
import Alamofire

class ServiceVK {
    
//    var friends = [Friend]()
    
    private let baseUrl = "https://api.vk.com"
    static let versionApiVk = "5.81"
    private var token = Session.instance.token
    private var myID = Session.instance.myID
//    private var friendID = Friend().userID
    
    enum MethodsRequest: String {
//        case authorize = "/blank.html"
        case friends = "/method/friends.get"
        case photos = "/method/photos.getAll"
        case groups = "/method/groups.get"
//        case searchGroups = "/method/groups.search"
        
        var parameters: [String: Any] {
            switch self {
            case .friends:
                return [
                    "fields": "name, photo_100"
                ]
            case .photos:
                return [
                    "photo_sizes": 1,
                    "type": "s"
                ]
            case .groups:
                return [
                    "fields": "description",
                    "extended": "1"
                ]
//            case .searchGroups:
//                return [
//                ]
            }
        }
        
    }
    // MARK: - getting Data from VK function
    /// load data
    func loadVKData(method: MethodsRequest, for userID: Int, completion: @escaping (Data?) -> Void ) {
        let path = method.rawValue
        var parameters: Parameters = method.parameters
        parameters["access_token"] = token
        parameters["user_id"] = userID
        parameters["owner_id"] = userID
        parameters["v"] = ServiceVK.versionApiVk
        let url = baseUrl + path
        print(url)
        
        /// Request with Alamofire
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else {
                print("no data")
                completion(nil)
                return
            }
            completion(data)
        }
    }
    
    func loadFriends(completion: @escaping ([Friend]) -> Void) {
        loadVKData(method: .friends, for: myID) { data in
            guard let data = data,
            let friendsResponse = try? JSONDecoder().decode(Friends.self, from: data)
            else {
                completion([])
                return
            }
            completion(friendsResponse.items)
        }
    }
    func loadGroups(completion: @escaping ([Group]) -> Void) {
        loadVKData(method: .groups, for: myID) { data in
            guard let data = data,
            let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data)
            else {
                completion([])
                return
            }
            completion(groupsResponse.items)
        }
    }
    func loadPhotos(for friendID: Int, completion: @escaping ([Photo]) -> Void) {
        loadVKData(method: .photos, for: friendID) { data in
            guard let data = data,
            let photosResponse = try? JSONDecoder().decode(Photos.self, from: data)
            else {
                completion([])
                return
            }
            completion(photosResponse.items)
        }
    }
    /// load data with searching
//    func loadVKData(method: MethodsRequest, searchText: String, completion: @escaping ([Item]) -> Void ) {
//        let path = method.rawValue
//
//        var parameters: Parameters = method.parameters
//        parameters["q"] = searchText
//        let url = baseUrl + path
//        print(url)
//
//        AF.request(url, method: .get, parameters: parameters).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let fromJSON = try JSONSerialization.jsonObject(with: data)
//                    print(fromJSON)
//                } catch {
//                    print("Decoding error from data: \(data)")
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    // MARK: - Autorisation function
    func autorisationVK() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8200914"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//            URLQueryItem(name: "scope", value: "327686"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
//            URLQueryItem(name: "scope", value: "offline"),
            URLQueryItem(name: "v", value: "5.131") ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
// MARK: - Error autorisation function
//    func showError() {
//        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//    }
    
//    // MARK: - methods API VK with urlComponents
//    func getFriendsVK() -> URLRequest {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/friends.get"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "access_token", value: Session.instance.token),
//            URLQueryItem(name: "fields", value: "nickname"),
//            URLQueryItem(name: "v", value: "5.81") ]
//        let request = URLRequest(url: urlComponents.url!)
//        print(urlComponents.url!)
//        return request
//    }
//
//    func getPhotosVK() -> URLRequest {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/photos.getAll"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "access_token", value: Session.instance.token),
//            URLQueryItem(name: "return_system", value: "true"),
//            URLQueryItem(name: "v", value: "5.81") ]
//        let request = URLRequest(url: urlComponents.url!)
//        return request
//    }
//
//    func getGroupsVK() -> URLRequest {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/groups.get"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "access_token", value: Session.instance.token),
//            URLQueryItem(name: "v", value: "5.81") ]
//        let request = URLRequest(url: urlComponents.url!)
//        return request
//    }
//
//    func getSearchGroupsVK() -> URLRequest {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/groups.search"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "access_token", value: Session.instance.token),
//            URLQueryItem(name: "q", value: "Swift"),
//            URLQueryItem(name: "type", value: "group"),
//            URLQueryItem(name: "v", value: "5.81") ]
//        let request = URLRequest(url: urlComponents.url!)
//        return request
//    }
    
    // MARK: - request with URLSession
//    func request(method: MethodsRequest) {
//        let path = method.rawValue
//        let stringUrl = "\(baseUrl)\(path)?access_token=\(token)&v=5.81"
//
//        guard let url = URL(string: stringUrl) else { return }
//        let data = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
//            self.parse(json: data!)
//        })
//        //            if let data = try? Data(contentsOf: url)
//    }
//
    
//    func parse(json: Data) {
//        let decoder = JSONDecoder()
//        if let jsonFriends = try? decoder.decode(Friends.self, from: json) {
//            friends = jsonFriends.friends
////            tableView.reloadData()
//        }
//    }
    
}
