//
//  EnterWordsView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 11.10.26.
//

import SwiftUI

struct EnterWordsView: View {

    // MARK: Input

    let playerName: String
    let playerNumber: Int
    let playersCount: Int
    let avatarColor: Color
    var onDone: ([String]) -> Void = { _ in }

    private let wordsCount = 10

    @State private var words: [String] = Array(repeating: "", count: 10)
    @FocusState private var focusedIndex: Int?

    private func isFilled(_ word: String) -> Bool {
        !word.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var filledCount: Int {
        words.filter(isFilled).count
    }

    private var visibleRows: Int {
        let lastFilled = words.lastIndex(where: isFilled) ?? -1
        return min(lastFilled + 2, wordsCount)
    }
    
    var body: some View {
        BaseScreenTеmplate(titleText: "Въведи твоите думи",
                           eyebrowText: "",
                           isButtonEnabled: filledCount == wordsCount,
                           onButtonTap: {
            focusedIndex = nil
            onDone(words.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) })
        }) {
            VStack(alignment: .leading, spacing: 16) {
                ContentCard_PlayerBar(
                    config: .init(initial: String(playerName.prefix(1)).uppercased(),
                                  title: "\(playerName)",
                                  subtitle: "Само съществителни · никой друг не гледа 🙈",
                                  avatarColor: avatarColor)
                )

                Indicator_ProgressDots(total: wordsCount, filled: filledCount)

                wordRows
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .task {
            focusedIndex = 0
        }
    }

    private var wordRows: some View {
        VStack(spacing: 8) {
            ForEach(0..<visibleRows, id: \.self) { index in
                InputCard_WordRow(
                    config: .init(number: index + 1, placeholder: "напиши дума…"), text: $words[index], onSubmit: { advance(from: index) })
                
                .focused($focusedIndex, equals: index)
            }
        }
    }

    // MARK: Actions

    private func advance(from index: Int) {
        // празен submit не мести фокуса — следващият ред още не съществува
        guard isFilled(words[index]) else { return }
        focusedIndex = index + 1 < wordsCount ? index + 1 : nil
    }
}

#Preview {
    NavigationStack {
        EnterWordsView(playerName: "Иво",
                       playerNumber: 2,
                       playersCount: 6,
                       avatarColor: ApplicationColors.firstTeamSurfaceColor)
    }
}
