//
//  Group.swift
//  MinionTeam
//
//  Created by MacBook on 13.05.2022.
//

import UIKit

//struct Group {
//    var name = String()
//    var avatar = UIImage()
//}

class Group: Item, Decodable {

    var name: String = ""
    var groupPhotoData: String = "" //url photos
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
