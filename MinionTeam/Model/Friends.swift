//
//  Friends.swift
//  MinionTeam
//
//  Created by MacBook on 19.06.2022.
//

import Foundation


class Friends: Decodable {
    var items: [Friend] = []
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    enum ResponseCodingKeys: String, CodingKey {
        case count
        case items
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: ResponseCodingKeys.self, forKey: .response)
        let items = try response.decode([Friend].self, forKey: .items)
        self.items = items
    }
}


