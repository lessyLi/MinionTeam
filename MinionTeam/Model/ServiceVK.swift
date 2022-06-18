//
//  ServiceVK.swift
//  MinionTeam
//
//  Created by MacBook on 16.06.2022.
//

import Foundation
import Alamofire

class ServiceVK {
//    let baseUrl = "https://api.vk.com"
//    let token = Session.instance.token
    
//    enum MethodsRequest: String {
//        case authorize = "/blank.html"
//        case friends = "/method/friends.get"
//        case photos = "/method/photos.getAll"
//        case groups = "/method/groups.get"
//        case searchGroups = "/method/groups.search"
//    }
//    
//    func getVkData(method: MethodsRequest) {
//        let path = method.rawValue
//        let parameters: Parameters = [
//            "access_token": token,
//            "v": "5.81"
//        ]
//        let url = baseUrl + path
//        AF.request(url, method: .get, parameters: parameters).responseDecodable { response in
//            print(response.value ?? "nothing")
//        }
//    }

    func autorisationVK() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8193451"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }

    
    func getFriendsVK() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }

    func getPhotosVK() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "return_system", value: "true"),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }

    func getGroupsVK() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }

    func getSearchGroupsVK() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "q", value: "Swift"),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
}
