//
//  ServiceVK.swift
//  MinionTeam
//
//  Created by MacBook on 16.06.2022.
//

import Foundation
import Alamofire
import RealmSwift

class ServiceVK {
    
//    var friends = [Friend]()
    
    private let baseUrl = "https://api.vk.com"
    static let versionApiVk = "5.81"
    private var token = Session.instance.token
    private var myID = Session.instance.myID
   // private var myID = 343939141
//    private var friendID = Friend().userID
    
    // MARK: - enum Methods Request
    enum MethodsRequest: String {
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
                    "type": "s",
                    "extended": "1"
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
    
    // MARK: - Общая функция получения данных VK (request - response)
 
    func loadVKData(method: MethodsRequest, for userID: Int, completion: @escaping (Data?) -> Void ) {
        let path = method.rawValue
        var parameters: Parameters = method.parameters
        parameters["access_token"] = token
        parameters["user_id"] = userID
        parameters["owner_id"] = userID
        parameters["v"] = ServiceVK.versionApiVk
        let url = baseUrl + path
        print(url)
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: - разные методы для VK (request - decode - realm)
    
    func loadFriends(completion: @escaping () -> Void) {
        loadVKData(method: .friends, for: myID) { data in
            guard
                let data = data,
                let friends = try? JSONDecoder().decode(Friends.self, from: data).items
            else { return }
            print(friends)
            do {
                /// тестовый режим, удаляются данные при конфликте, требующем миграции
                //                var config = Realm.Configuration.defaultConfiguration
                //                config.deleteRealmIfMigrationNeeded = true
                //                let realm = try Realm(configuration: config)
                let realm = try Realm()
                try realm.write {
                    let oldFriends = realm.objects(Friend.self)
                    realm.delete(oldFriends)
                    realm.add(friends)
                    print(realm.configuration.fileURL?.absoluteString ?? "NO REALM URL")
                }
                completion()
            } catch {
                print(error)
            }
        }
    }
    
    func loadGroups(completion: @escaping () -> Void) {
        loadVKData(method: .groups, for: myID) { data in
            guard
                let data = data,
                let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data)
            else { return }
            
            do {
                let realm = try Realm()
                try realm.write {
                    let oldGroups = realm.objects(Group.self)
                    realm.delete(oldGroups)
                    realm.add(groupsResponse.items)
                }
                completion()
            } catch {
                print(error)
            }
        }
    }
    
    func loadPhotos(for friendID: Int, completion: @escaping () -> Void) {
        loadVKData(method: .photos, for: friendID) { data in
            guard
                let data = data,
                let photosResponse = try? JSONDecoder().decode(Photos.self, from: data)
            else { return }
            print(photosResponse.items)
            do {
                let realm = try Realm()
                try realm.write {
                    let oldPhotos = realm.objects(Photo.self)
                    realm.delete(oldPhotos)
                    realm.add(photosResponse.items)
                }
                completion()
            } catch {
                print(error)
            }
        }
    }
    
    //    func loadFriends(completion: @escaping ([Friend]) -> Void) {
    //        loadVKData(method: .friends, for: myID) { data in
    //            guard let data = data,
    //            let friendsResponse = try? JSONDecoder().decode(Friends.self, from: data)
    //            else {
    //                completion([])
    //                return
    //            }
    //            completion(friendsResponse.items)
    //        }
    //    }
    
//    func loadGroups(completion: @escaping ([Group]) -> Void) {
//        loadVKData(method: .groups, for: myID) { data in
//            guard let data = data,
//            let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data)
//            else {
//                completion([])
//                return
//            }
//            completion(groupsResponse.items)
//        }
//    }
//    func loadPhotos(for friendID: Int, completion: @escaping ([Photo]) -> Void) {
//        loadVKData(method: .photos, for: friendID) { data in
//            guard let data = data,
//            let photosResponse = try? JSONDecoder().decode(Photos.self, from: data)
//            else {
//                completion([])
//                return
//            }
//            completion(photosResponse.items)
//        }
//    }
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
