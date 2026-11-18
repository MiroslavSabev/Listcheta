//
//  RoundEndView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 27.10.26.
//

import SwiftUI

// Екран 05 · Край на рунда (общ за всички режими).
// .singlePhone — „Един телефон“: бутонът винаги е активен.
// .host        — стая, домакин: само той вижда активния бутон.
// .guest       — стая, всички останали: waitnote вместо бутон.
enum RoundEndRole {
    case singlePhone
    case host
    case guest
}

struct RoundEndTeamResult {
    let name: String
    let surfaceColor: Color
    /// Листчета, познати в този рунд.
    let roundPoints: Int
}

struct RoundEndCarry {
    let playerName: String
    let time: String
}

struct RoundEndView: View {

    let roundNumber: Int
    var totalRounds: Int = 3
    let firstTeam: RoundEndTeamResult
    let secondTeam: RoundEndTeamResult
    /// Пренесено време към следващия рунд (няма, ако времето е свършило точно на 0:00).
    var carry: RoundEndCarry? = nil
    var role: RoundEndRole = .singlePhone
    var onContinue: () -> Void = {}

    private var isLastRound: Bool { roundNumber >= totalRounds }

    private var buttonTitle: String {
        isLastRound ? "Виж победителя" : "Разбъркай купата → Рунд \(roundNumber + 1)"
    }

    var body: some View {
        BaseScreenTеmplate(titleText: "Рунд \(roundNumber)\nприключи 🎉",
                           eyebrowText: "Купата е празна",
                           buttonTitle: buttonTitle,
                           isButtonHidden: role == .guest,
                           onButtonTap: onContinue) {
            VStack(spacing: 12) {
                ContentCard_Score(config: scoreConfig(for: firstTeam))
                ContentCard_Score(config: scoreConfig(for: secondTeam))

                if let carry, !isLastRound {
                    ContentCard_Carry(config: .init(playerName: carry.playerName,
                                                    time: carry.time,
                                                    nextRoundNumber: roundNumber + 1))
                        .padding(.top, 4)
                }
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .safeAreaInset(edge: .bottom) {
            if role == .guest {
                Indicator_WaitNote(text: waitText)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private var waitText: String {
        isLastRound ? "Домакинът показва победителя…" : "Домакинът стартира Рунд \(roundNumber + 1)…"
    }

    private func scoreConfig(for team: RoundEndTeamResult) -> ScoreCardConfig {
        .init(teamName: team.name,
              subtitle: "+\(team.roundPoints) \(team.roundPoints == 1 ? "листче" : "листчета") този рунд",
              points: team.roundPoints,
              surfaceColor: team.surfaceColor)
    }
}

#Preview("Един телефон") {
    NavigationStack {
        RoundEndView(roundNumber: 1,
                     firstTeam: .init(name: "🩷 Розовите",
                                      surfaceColor: ApplicationColors.secondTeamSurfaceColor,
                                      roundPoints: 12),
                     secondTeam: .init(name: "🌊 Тюркоазите",
                                       surfaceColor: ApplicationColors.firstTeamSurfaceColor,
                                       roundPoints: 8),
                     carry: .init(playerName: "Мария", time: "0:23"))
    }
}

#Preview("Стая · гост") {
    NavigationStack {
        RoundEndView(roundNumber: 1,
                     firstTeam: .init(name: "🩷 Розовите",
                                      surfaceColor: ApplicationColors.secondTeamSurfaceColor,
                                      roundPoints: 12),
                     secondTeam: .init(name: "🌊 Тюркоазите",
                                       surfaceColor: ApplicationColors.firstTeamSurfaceColor,
                                       roundPoints: 8),
                     role: .guest)
    }
}
