//
//  Word.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.11.26.
//

import Foundation

struct Word: Identifiable, Codable {
    let id: UUID
    let text: String
    let authorID: Player.ID
    
    init(id: UUID = UUID(), text: String, authorID: Player.ID) {
        self.id = id
        self.text = text
        self.authorID = authorID
    }
}
