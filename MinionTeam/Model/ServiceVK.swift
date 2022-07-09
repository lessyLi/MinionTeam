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
        case searchGroups = "/method/groups.search"
        
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
    
    // MARK: - Friends
    
    func loadFriends(method: MethodsRequest, for id: Int) {
        
        let path = method.rawValue
        let parameters: Parameters = [
            "access_token": token,
            "user_id": id,
            "owner_id": id,
            "v": ServiceVK.versionApiVk,
            "fields": "name, photo_100"
        ]
        let url = baseUrl + path
        print(url)
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    guard let friends = try? JSONDecoder().decode(Friends.self, from: data).items else { return }
                    
                    let realm = try Realm()
                    try realm.write {
                        realm.add(friends, update: .modified)
                        print(realm.configuration.fileURL?.absoluteString ?? "NO REALM URL")
                    }
                }catch {
                    print("Error while decoding response from \(#function)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: - Groups
    func loadGroups(method: MethodsRequest, for id: Int) {
        
        let path = method.rawValue
        let parameters: Parameters = [
            "access_token": token,
            "user_id": id,
            "owner_id": id,
            "v": ServiceVK.versionApiVk,
            "fields": "description",
            "extended": "1"
        ]
        let url = baseUrl + path
        print(url)
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    guard let groups = try? JSONDecoder().decode(Groups.self, from: data).items else { return }
                    
                    let realm = try Realm()
                    try realm.write {
                        realm.add(groups, update: .modified)
                        print(realm.configuration.fileURL?.absoluteString ?? "NO REALM URL")
                    }
                }catch {
                    print("Error while decoding response from \(#function)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // loading groups data with searching
    func loadMoreGroups(method: MethodsRequest, for id: Int, searchText: String, completion: @escaping ([Group]) -> Void) {
        let path = method.rawValue
        
        let parameters: Parameters = [
            "access_token": token,
            "user_id": id,
            "owner_id": id,
            "v": ServiceVK.versionApiVk,
            "q": searchText,
            "fields": "description",
            "extended": "1"
        ]
        let url = baseUrl + path
        print(url)

        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data)
                    print(groupsResponse)
                    completion(groupsResponse?.items ?? [])
                } catch {
                    print("Decoding error from data: \(data)")
                    completion([])
                }
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    // MARK: - Photos
    func loadPhotos(method: MethodsRequest, for id: Int) {
        
        let path = method.rawValue
        let parameters: Parameters = [
            "access_token": token,
            "user_id": id,
            "owner_id": id,
            "v": ServiceVK.versionApiVk,
//            "photo_sizes": 1,
//            "type": "s",
            "extended": "1"
        ]
        let url = baseUrl + path
        print(url)
        
        AF.request(url, method: .get, parameters: parameters).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    let photos = try JSONDecoder().decode(Photos.self, from: data).items
                    self?.writePhotoData(photos)
                }catch {
                    let photos: [Photo] = []
                    self?.writePhotoData(photos)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func writePhotoData(_ photos: [Photo]) {
        do {
            let realm = try Realm()
            try realm.write {
                let oldPhotos = realm.objects(Photo.self)
                realm.delete(oldPhotos)
                realm.add(photos, update: .all)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Матрешка
 
//    var parameters: [String: Any] {
//        switch self {
//        case .friends:
//            return [
//                "fields": "name, photo_100"
//            ]
//        case .photos:
//            return [
//                "photo_sizes": 1,
//                "type": "s",
//                "extended": "1"
//            ]
//        case .groups:
//            return [
//                "fields": "description",
//                "extended": "1"
//            ]
////            case .searchGroups:
////                return [
////                ]
//        }
//    }
    
//    func loadVKData(method: MethodsRequest, for userID: Int, completion: @escaping (Data?) -> Void ) {
//        let path = method.rawValue
//        var parameters: Parameters = method.parameters
//        parameters["access_token"] = token
//        parameters["user_id"] = userID
//        parameters["owner_id"] = userID
//        parameters["v"] = ServiceVK.versionApiVk
//        let url = baseUrl + path
//        print(url)
//
//        AF.request(url, method: .get, parameters: parameters).responseData { response in
//            switch response.result {
//            case .success(let data):
//                completion(data)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//    func loadFriends() {
////        func loadFriends(completion: @escaping () -> Void) {
//        loadVKData(method: .friends, for: myID) { data in
//            guard
//                let data = data,
//                let friends = try? JSONDecoder().decode(Friends.self, from: data).items
//            else { return }
//            print(friends)
//            do {
//                /// тестовый режим, удаляются данные при конфликте, требующем миграции
//                //                var config = Realm.Configuration.defaultConfiguration
//                //                config.deleteRealmIfMigrationNeeded = true
//                //                let realm = try Realm(configuration: config)
//                let realm = try Realm()
//                try realm.write {
////                    let oldFriends = realm.objects(Friend.self)
////                    realm.delete(oldFriends)
////                    realm.add(friends)
//                    realm.add(friends, update: .modified)
//                    print(realm.configuration.fileURL?.absoluteString ?? "NO REALM URL")
//                }
////                completion()
//            } catch {
//                print(error)
//            }
//        }
//    }
//
//    func loadGroups() {
////    func loadGroups(completion: @escaping () -> Void) {
//        loadVKData(method: .groups, for: myID) { data in
//            guard
//                let data = data,
//                let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data)
//            else { return }
//
//            do {
//                let realm = try Realm()
//                try realm.write {
////                    let oldGroups = realm.objects(Group.self)
////                    realm.delete(oldGroups)
//                    realm.add(groupsResponse.items, update: .modified)
//                }
////                completion()
//            } catch {
//                print(error)
//            }
//        }
//    }
//    func loadPhotos(for friendID: Int) {
////    func loadPhotos(for friendID: Int, completion: @escaping () -> Void) {
//        loadVKData(method: .photos, for: friendID) { data in
//            guard
//                let data = data,
//                let photos = try? JSONDecoder().decode(Photos.self, from: data).items
//            else { return }
//            print(photos)
//            do {
//                let realm = try Realm()
//                try realm.write {
//                    let oldPhotos = realm.objects(Photo.self)
//                    realm.delete(oldPhotos)
//                    realm.add(photos, update: .all)
//                }
////                completion()
//            } catch {
//                print(error)
//            }
//        }
//    }
    
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
