//
//  WinnerView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 15.11.26.
//

import SwiftUI

// 06 · Победител (design-system.html #finale → .s8)
// Общ финален екран — еднакъв във всички режими на игра.
struct WinnerView: View {

    let winnerTeamName: String
    let winnerScore: Int
    let loserScore: Int
    var roundsCount: Int = 3
    var onRematch: () -> Void = {}
    var onNewGame: () -> Void = {}

    var body: some View {
        ZStack {
            background
            Decoration_Confetti()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer(minLength: 0)
                resultBlock
                Spacer(minLength: 0)
                buttons
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: Секции

    private var background: some View {
        LinearGradient(
            colors: [ApplicationColors.finaleBackgroundTopColor,
                     ApplicationColors.finaleBackgroundBottomColor],
            startPoint: UnitPoint(x: 0.41, y: 0),   // ≈ 170° от дизайна
            endPoint: UnitPoint(x: 0.59, y: 1)
        )
        .ignoresSafeArea()
    }

    private var resultBlock: some View {
        VStack(spacing: 0) {
            ContentCard_TrophySlip(config: .init(teamName: winnerTeamName))
                .padding(.bottom, 26)

            Text("Победители след\n\(roundsCount) рунда!")
                .font(ApplicationTypography.UIFont_FinaleTitle)
                .foregroundStyle(ApplicationColors.finaleTitleColor)
                .multilineTextAlignment(.center)
                .lineSpacing(2)

            score
                .padding(.top, 14)
        }
        .accessibilityElement(children: .combine)
    }

    private var score: some View {
        HStack(alignment: .lastTextBaseline, spacing: 14) {
            Text("\(winnerScore)")
                .font(ApplicationTypography.UIFont_FinaleScore)
                .foregroundStyle(ApplicationColors.finaleScoreValueColor)

            Text(":")
                .font(ApplicationTypography.UIFont_FinaleScoreSeparator)
                .foregroundStyle(ApplicationColors.finaleScoreSeparatorColor)

            Text("\(loserScore)")
                .font(ApplicationTypography.UIFont_FinaleScore)
                .foregroundStyle(ApplicationColors.finaleScoreValueColor)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Резултат")
        .accessibilityValue("\(winnerScore) на \(loserScore)")
    }

    private var buttons: some View {
        VStack(spacing: 16) {
            Button(action: onRematch) {
                Text("Реванш със същите отбори")
            }
            .buttonStyle(AccentButtonStyle())

            Button(action: onNewGame) {
                Text("Нова игра")
            }
            .buttonStyle(GhostButtonStyle(
                borderColor: ApplicationColors.buttonGhostOnDarkBorderColor,
                textColor: ApplicationColors.buttonGhostOnDarkTextColor
            ))
        }
    }
}

#Preview {
    NavigationStack {
        WinnerView(winnerTeamName: "Розовите",
                   winnerScore: 34,
                   loserScore: 27)
    }
}
