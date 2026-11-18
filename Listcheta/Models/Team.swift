//
//  Team.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.11.26.
//

import Foundation


enum TeamSlot: String, Codable {
    case First
    case Second
}


struct Team: Identifiable, Codable {
    let id: UUID
    let slot: TeamSlot
    var name: String
    
    init(id: UUID = UUID(), slot: TeamSlot, name: String) {
        self.id = id
        self.slot = slot
        self.name = name
    }
}
