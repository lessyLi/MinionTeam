//
//  Groups.swift
//  MinionTeam
//
//  Created by MacBook on 22.06.2022.
//

import Foundation

class Groups: Decodable {
    var items: [Group] = []
    
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
        let items = try response.decode([Group].self, forKey: .items)
        self.items = items
    }
}
