//
//  AddPlayersNamesSreen.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 27.09.26.
//

import SwiftUI
private extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet(charactersIn: "#")))
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >> 8) & 0xFF) / 255,
            blue: Double(rgb & 0xFF) / 255
        )
    }
}

struct AddPlayersNamesSreen: View {

    @State private var isPrimaryButtonTapped = false
    @State private var teamA = [TeamPlayer]()
    @State private var teamB = [TeamPlayer]()

    // ако TeamPlayer има друго име на полето, смени `name`
    private var allPlayers: [WordsPlayer] {
        let pink = teamA
            .filter { !$0.name.trimmingCharacters(in: .whitespaces).isEmpty }
            .map { WordsPlayer(name: $0.name, color: ApplicationColors.secondTeamSurfaceColor) }
        let turquoise = teamB
            .filter { !$0.name.trimmingCharacters(in: .whitespaces).isEmpty }
            .map { WordsPlayer(name: $0.name, color: ApplicationColors.firstTeamSurfaceColor) }
        return pink + turquoise
    }

    var body: some View {
        BaseScreenTеmplate(titleText: "Кой играе в отборите?",
                           onButtonTap: {
            isPrimaryButtonTapped = true
        }) {
            HStack(spacing: 9) {
                TeamPlayersColumn(
                    teamName: "🩷 Розовите",
                    teamColor: ApplicationColors.secondTeamSurfaceColor,
                    headerTextColor: Color(hex: "#C2185B"),
                    players: $teamA
                )
                TeamPlayersColumn(
                    teamName: "🌊 Тюркоазите",
                    teamColor: ApplicationColors.firstTeamSurfaceColor,
                    headerTextColor: Color(hex: "#00877A"),
                    players: $teamB
                )
            }
            .padding(.horizontal)
        }
        .navigationDestination(isPresented: $isPrimaryButtonTapped) {
            WordsFlowView(players: allPlayers) { allWords in
                // всички са въвели думи: тук отваряш следващия екран (играта)
                print(allWords)
            }
        }
    }
}

#Preview {
    AddPlayersNamesSreen()
}
