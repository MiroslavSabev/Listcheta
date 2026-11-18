//
//  PassToNextView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 2.11.26.
//

import SwiftUI

// Екран 03 · „Предай на следващия“ (режим „Един телефон“).
// Целият екран е в цвета на отбора на играча (градиент 170° → по-тъмен край).
struct PassToNextView: View {

    let config: PlayerHandoffConfig
    var buttonTitle: String = "Готова съм — старт!"
    var onStart: () -> Void = {}

    // #FF5C8A → #E0447A (teamA → teamADark) ≈ 12% към черно
    private var gradient: LinearGradient {
        LinearGradient(
            colors: [config.teamColor,
                     config.teamColor.mix(with: .black, by: 0.12)],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)

            ContentCard_PlayerHandoff(config: config)
                .padding(.horizontal, 24)

            Spacer(minLength: 0)

            Button(action: onStart) {
                Text(buttonTitle)
            }
            .buttonStyle(OnColorButtonStyle(textColor: config.teamColor))
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(gradient.ignoresSafeArea())
        .navigationBarBackButtonHidden(true) // да не се връща и да види чужди думи/екрани        // светъл status bar върху цветния фон
    }
}

#Preview {
    NavigationStack {
        PassToNextView(
            config: .init(playerName: "Мария",
                          teamTitle: "ОТБОР РОЗОВИТЕ",
                          teamColor: ApplicationColors.firstTeamSurfaceColor,
                          carriedTime: "0:23")
        )
    }
}
