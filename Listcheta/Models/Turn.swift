//
//  Turn.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.11.26.
//

import Foundation

struct Turn: Codable {
    let explainerID: Player.ID
    var secondsLeft: Int
    var currentWordID: Word.ID?
    var guessedCount = 0                       // „Този ход +3"
}
