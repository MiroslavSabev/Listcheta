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

    private let maxPlayersPerTeam = 10

    @State private var isPrimaryButtonTapped = false
    @State private var isConfirmationShown = false
    @State private var scrollRequest: ScrollRequest?
    @State private var teamA = [TeamPlayer]()
    @State private var teamB = [TeamPlayer]()

    private func validNames(_ team: [TeamPlayer]) -> [TeamPlayer] {
        team.filter { !$0.name.trimmingCharacters(in: .whitespaces).isEmpty }
    }

    // поне един играч във всеки отбор
    private var canContinue: Bool {
        !validNames(teamA).isEmpty && !validNames(teamB).isEmpty
    }

    private var allPlayers: [WordsPlayer] {
        let pink = validNames(teamA)
            .map { WordsPlayer(name: $0.name, color: ApplicationColors.secondTeamSurfaceColor) }
        let turquoise = validNames(teamB)
            .map { WordsPlayer(name: $0.name, color: ApplicationColors.firstTeamSurfaceColor) }
        return pink + turquoise
    }

    private var confirmationMessage: String {
        let pinkNames = validNames(teamA).map(\.name).joined(separator: ", ")
        let turquoiseNames = validNames(teamB).map(\.name).joined(separator: ", ")
        return "🩷 Розовите: \(pinkNames)\n🌊 Тюркоазите: \(turquoiseNames)"
    }

    // rowID: реда, до който да се превърти; keyboardAppearing: чакаме ли клавиатурата да се вдигне
    private func requestScroll(to rowID: String, keyboardAppearing: Bool) {
        scrollRequest = ScrollRequest(id: rowID,
                                      delay: keyboardAppearing ? 0.35 : 0.1)
    }

    var body: some View {
        BaseScreenTеmplate(titleText: "Кой играе в отборите?",
                           isButtonEnabled: canContinue,
                           scrollRequest: $scrollRequest,
                           onButtonTap: {
            // свали клавиатурата, за да се запише недовършеното име
            forceResignKeyboard()
            DispatchQueue.main.async {
                isConfirmationShown = true
            }
        }) {
            HStack(spacing: 9) {
                TeamPlayersColumn(
                    teamName: "🩷 Розовите",
                    teamColor: ApplicationColors.secondTeamSurfaceColor,
                    headerTextColor: Color(hex: "#C2185B"),
                    players: $teamA,
                    maxPlayers: maxPlayersPerTeam,
                    onScrollNeeded: requestScroll
                )
                TeamPlayersColumn(
                    teamName: "🌊 Тюркоазите",
                    teamColor: ApplicationColors.firstTeamSurfaceColor,
                    headerTextColor: Color(hex: "#00877A"),
                    players: $teamB,
                    maxPlayers: maxPlayersPerTeam,
                    onScrollNeeded: requestScroll
                )
            }
            .padding(.horizontal)
            // тап по празното място зад колоните сваля клавиатурата;
            // тапове върху полета и бутони не стигат дотук
            .background(
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { forceResignKeyboard() }
            )
            .frame(minHeight: 420, alignment: .top)
        }
        .alert("Всичко точно ли е с отборите?",
               isPresented: $isConfirmationShown) {
            Button("Провери отново", role: .cancel) { }
            Button("Да, продължи") {
                isPrimaryButtonTapped = true
            }
        } message: {
            Text(confirmationMessage)
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
