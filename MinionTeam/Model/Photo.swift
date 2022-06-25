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

    @Persisted var photoDescription: String = ""
    @Persisted var type: String = ""
    @Persisted var collectionPhotoData: String = ""
    var friendPhoto: UIImage = #imageLiteral(resourceName: "groups")
    
    enum CodingKeys: String, CodingKey {
        case sizes
        case photoDescription = "text"
    }
    enum SizesCodingKeys: String, CodingKey {
        case type
        case collectionPhotoData = "url"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.photoDescription = try container.decode(String.self, forKey: .photoDescription)
        
        var sizeContainer = try container.nestedUnkeyedContainer(forKey: .sizes)

        _ = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        _ = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        _ = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        _ = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        
        let sizes = try sizeContainer.nestedContainer(keyedBy: SizesCodingKeys.self)
        self.type = try sizes.decode(String.self, forKey: .type)
        self.collectionPhotoData = try sizes.decode(String.self, forKey: .collectionPhotoData)
    }
    
}
