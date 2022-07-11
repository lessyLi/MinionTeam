//
//  addedGroups.swift
//  MinionTeam
//
//  Created by MacBook on 09.07.2022.
//

import Foundation

struct AddedGroups: Decodable {
    let userID: Int
    var groups: [Group]
    
    var toAnyObject: Any {
        return [
            "id": userID,
            "groupID": groups.map { $0.groupID}
        ]
    }
}
