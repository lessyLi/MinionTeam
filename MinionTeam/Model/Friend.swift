//
//  Friend.swift
//  MinionTeam
//
//  Created by MacBook on 13.05.2022.
//

import UIKit
import RealmSwift
import Kingfisher

class Friend: Object, Decodable {

    @Persisted var userID: Int = 0
    @Persisted var name: String = ""
    @Persisted var lastName: String = ""
    @Persisted var userPhotoData: String = ""
    var avatar: UIImage = #imageLiteral(resourceName: "16.-phill") //вот это потом превратится в фото из стрингов avatar
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name = "first_name"
        case lastName = "last_name"
        case userPhotoData = "photo_100"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(Int.self, forKey: .userID)
        self.name = try container.decode(String.self, forKey: .name)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.userPhotoData = try container.decode(String.self, forKey: .userPhotoData)
    }
    
}

//struct Friend {
//    var name = String()
//    var avatar = UIImage()
//    var photos = [UIImage]()
//}
