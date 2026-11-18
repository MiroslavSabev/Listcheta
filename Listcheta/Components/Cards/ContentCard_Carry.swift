//
//  ContentCard_Carry.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 27.10.26.
//

import SwiftUI

// design-system.html #cards → .carrycard (radius 16 · иконна плочка 36×36 · radius 11 · sun)
struct CarryCardConfig {
    var icon: String = "⏸"
    let playerName: String
    let time: String
    let nextRoundNumber: Int
}

struct ContentCard_Carry: View {
    let config: CarryCardConfig

    var body: some View {
        HStack(spacing: 12) {
            Text(config.icon)
                .font(ApplicationTypography.UIFont_CarryCardIcon)
                .frame(width: 36, height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .fill(ApplicationColors.carryCardIconSurfaceColor)
                )

            message
                .font(ApplicationTypography.UIFont_CarryCardText)
                .foregroundStyle(ApplicationColors.carryCardTextColor)
                .lineSpacing(3)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 13)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(ApplicationColors.carryCardSurfaceColor)
        )
        .shadow(color: ApplicationColors.textPrimaryColor.opacity(0.1),
                radius: 6, x: 0, y: 4)
        .accessibilityElement(children: .combine)
    }

    // Подчертаните стойности са в textAccent (#C2185B)
    private var message: Text {
        Text("Времето на \(accent(config.playerName)) е паузирано на \(accent(config.time)). Продължава Рунд \(config.nextRoundNumber) с останалото си време.")
    }

    private func accent(_ value: String) -> Text {
        Text(value)
            .font(ApplicationTypography.UIFont_CarryCardAccent)
            .foregroundStyle(ApplicationColors.carryCardAccentTextColor)
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                ContentCard_Carry(config: .init(playerName: "Мария",
                                                time: "0:23",
                                                nextRoundNumber: 2))
                    .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
