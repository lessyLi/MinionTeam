//
//  Session.swift
//  MinionTeam
//
//  Created by MacBook on 12.06.2022.
//

import Foundation

class Session {
    
    static let instance = Session()
    
    private init() {}
    
    var token = ""
    var myID = 0
}
