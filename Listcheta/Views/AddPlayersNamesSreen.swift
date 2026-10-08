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
    
    @State private var isPrimaryButtonTapped: Bool = false
    
    @State private var teamA = [TeamPlayer]()
    @State private var teamB = [TeamPlayer]()
    
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
    }
}

#Preview {
    AddPlayersNamesSreen()
}
