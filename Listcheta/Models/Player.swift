//
//  Player.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.11.26.
//

import Foundation

struct Player: Identifiable, Codable {
    let id: UUID
    var name: String
    let teamID: Team.ID
    
    init(id: UUID = UUID(), name: String, teamID: Team.ID) {
        self.id = id
        self.name = name
        self.teamID = teamID
    }
}
