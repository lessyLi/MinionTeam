//
//  NewsResponse.swift
//  MinionTeam
//
//  Created by MacBook on 12.07.2022.
//

import Foundation

class NewsResponse: Decodable {
    var items: [News] = []
    var groups: [Int: Group] = [:]
    var profiles: [Int: Friend] = [:]
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    enum ResponseKeys: String, CodingKey {
        case items
        case groups
        case profiles
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseValue = try container.nestedContainer(keyedBy: ResponseKeys.self, forKey: .response)
        self.items = try responseValue.decode([News].self, forKey: .items)
        self.groups = try responseValue.decode([Group].self, forKey: .groups).reduce(into: [Int: Group](), { partialResult, group in
            partialResult[group.groupID] = group
        })
        self.profiles = try responseValue.decode([Friend].self, forKey: .profiles).reduce(into: [Int: Friend](), { partialResult, profile in
            partialResult[profile.userID] = profile
        })
    }
}
