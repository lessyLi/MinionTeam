//
//  Photo.swift
//  MinionTeam
//
//  Created by MacBook on 22.06.2022.
//

import Foundation
import UIKit
import RealmSwift
import Kingfisher

class Photo: Object, Decodable {

    @Persisted var photoID: Int = 0
    @Persisted var photoDescription: String = ""
//    @Persisted var likesCount: Int = 0
    @Persisted var type: String = ""
   // @Persisted var collectionPhotoData: String = ""
    @Persisted var photoDict = Map<String, String>()
//    @Persisted(originProperty: "photos") var friend: LinkingObjects<Friend>
    var friendPhoto: UIImage = #imageLiteral(resourceName: "groups")
    
    override class func primaryKey() -> String? {
            return "photoID"
        }
    
    enum CodingKeys: String, CodingKey {
        case photoID = "id"
        case sizes
        case photoDescription = "text"
//        case likes
//        case likesCount = "count"
    }
    enum SizesCodingKeys: String, CodingKey {
        case type
        case collectionPhotoData = "url"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.photoDescription = try container.decode(String.self, forKey: .photoDescription)
        self.photoID = try container.decode(Int.self, forKey: .photoID)
        
//        let likes = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .likes)
//        self.likesCount = try likes.decode(Int.self, forKey: .likesCount)
        
        var sizeContainer = try container.nestedUnkeyedContainer(forKey: .sizes)
        while !sizeContainer.isAtEnd {
            let secondSize = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
            let type = try secondSize.decode(String.self, forKey: .type)
            let collectionPhotoData = try secondSize.decode(String.self, forKey: .collectionPhotoData)
            self.photoDict.updateValue(collectionPhotoData, forKey: type)
        }
    }
}
