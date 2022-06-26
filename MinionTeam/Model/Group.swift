//
//  Group.swift
//  MinionTeam
//
//  Created by MacBook on 13.05.2022.
//

import UIKit
import RealmSwift
import Kingfisher
//struct Group {
//    var name = String()
//    var avatar = UIImage()
//}

class Group: Object, Decodable {

    @Persisted var name: String = ""
    @Persisted var groupPhotoData: String = "" //url photos
    var avatar: UIImage = #imageLiteral(resourceName: "selfie") //вот это потом превратится в фото из стрингов avatar
    
    enum CodingKeys: String, CodingKey {
        case name
        case groupPhotoData = "photo_100"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.groupPhotoData = try container.decode(String.self, forKey: .groupPhotoData)
    }
}
