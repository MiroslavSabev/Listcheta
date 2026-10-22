//
//  WordsFlowView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 22.10.26.
//

import SwiftUI

struct WordsPlayer: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

struct WordsFlowView: View {

    let players: [WordsPlayer]
    var onFinish: ([UUID: [String]]) -> Void = { _ in }

    @State private var currentIndex = 0
    @State private var allWords: [UUID: [String]] = [:]

    var body: some View {
        if players.indices.contains(currentIndex) {
            let player = players[currentIndex]

            EnterWordsView(
                playerName: player.name,
                playerNumber: currentIndex + 1,
                playersCount: players.count,
                avatarColor: player.color,
                onDone: { words in
                    allWords[player.id] = words
                    if currentIndex + 1 < players.count {
                        currentIndex += 1
                    } else {
                        onFinish(allWords)
                    }
                }
            )
            .id(currentIndex) // нов екран за всеки играч: ресетва @State и фокуса
            .navigationBarBackButtonHidden(true) // да не може да се връща и да види чужди думи
        }
    }
}
