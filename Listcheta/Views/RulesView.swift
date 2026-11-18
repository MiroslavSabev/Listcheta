//
//  RulesView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 17.11.26.
//

import SwiftUI

struct RulesView: View {

    @Environment(\.dismiss) private var dismiss

    private let rules: [RuleCardConfig] = [
        .init(badge: "1",
              title: "Свободно обяснение",
              description: "Описвай думата с други думи. Забранено е да използваш корена ѝ.",
              badgeSurfaceColor: ApplicationColors.ruleBadgeFirstSurfaceColor),
        .init(badge: "2",
              title: "Само една дума",
              description: "Същите листчета, но имаш право на една-единствена дума за всяко.",
              badgeSurfaceColor: ApplicationColors.ruleBadgeSecondSurfaceColor),
        .init(badge: "3",
              title: "Мимики и жестове",
              description: "Без говорене и без звуци — само с тяло и жестове.",
              badgeSurfaceColor: ApplicationColors.ruleBadgeThirdSurfaceColor,
              badgeTextColor: ApplicationColors.ruleBadgeDarkTextColor),
        .init(badge: "📱",
              title: "Един или повече телефони",
              description: "Играе се еднакво — с подаване на един телефон или всеки със свой в обща стая.",
              badgeSurfaceColor: ApplicationColors.ruleBadgeFourthSurfaceColor)
    ]

    var body: some View {
        BaseScreenTеmplate(titleText: "3 рунда,\nедна купа",
                           eyebrowText: "ПРАВИЛА",
                           buttonTitle: "Назад",
                           onButtonTap: { dismiss() }) {
            VStack(spacing: 12) {
                ForEach(rules.indices, id: \.self) { index in
                    ContentCard_Rule(config: rules[index])
                }
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        RulesView()
    }
}
