//
//  RoundStartupScreen.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 24.10.26.
//

import SwiftUI

struct RoundStartupScreen: View {

    var firstExplainerName: String = "Иван"
    var roundNumber: Int = 1
    var totalRounds: Int = 3
    var roundTitle: String = "Свободно\nобяснение"
    var roundDescription: String = "Обяснявай с колкото искаш думи, но не използвай корена на думата от листчето."
    var pillTitles: [String] = ["Думи", "1 дума", "Мимики"]
    var onStart: () -> Void = {}

    @State private var navigateToExplainer = false

    var body: some View {

        VStack(spacing: 0) {

            VStack() {
                Illustration_Bowl()
                    .padding(.top, 16)

                roundInfo

                Chips_RoundPills(config: .init(titles: pillTitles,
                                               activeIndex: roundNumber - 1))
                .padding(.top, 14)
            }.frame(maxHeight: .infinity, alignment: .center)


            ContentCard_Handoff(config: .init(label: "Първи обяснява",
                                              name: firstExplainerName))
            .padding(.horizontal)
            .padding(.bottom, 18)

            Button(action: {
                onStart()
                navigateToExplainer = true
            }) {
                Text("Старт")
            }
            .buttonStyle(AccentButtonStyle())
            .padding(.horizontal)
            .padding(.bottom)


        }
        .padding(.top, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(ApplicationColors.darkScreenBackgroundColor.ignoresSafeArea())
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .environment(\.colorScheme, .light)
        .navigationDestination(isPresented: $navigateToExplainer) {
            ExplainerScreen(config: .init(
                word: "пеперуда",
                roundNumber: roundNumber,
                totalRounds: totalRounds,
                roundTitle: roundTitle,
                cardsInBowl: 14,
                scoreThisTurn: 0
            ))
        }
    }

    private var roundInfo: some View {
        VStack(spacing: 0) {
            Text("РУНД \(roundNumber) / \(totalRounds)")
                .font(ApplicationTypography.UIFont_RoundNumberCompact)
                .tracking(3.64) // 28% от 13pt
                .foregroundStyle(ApplicationColors.roundNumberColor)
                .padding(.top, 22)

            Text(roundTitle)
                .font(ApplicationTypography.UIFont_RoundNameCompact)
                .foregroundStyle(ApplicationColors.textOnDarkPrimaryColor)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .padding(.bottom, 8)

            Text(roundDescription)
                .font(ApplicationTypography.UIFont_RoundDescriptionCompact)
                .foregroundStyle(ApplicationColors.textOnDarkSecondaryColor)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .frame(maxWidth: 250)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    NavigationStack {
        RoundStartupScreen()
    }
}