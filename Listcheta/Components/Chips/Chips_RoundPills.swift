//
//  Chips_RoundPills.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 24.10.26.
//

import SwiftUI

// MARK: - Токени (design-system.html → .rpills / .rpill / .rpill.on)
private enum RoundPillMetrics {
    static let spacing: CGFloat = 8
    static let verticalPadding: CGFloat = 8
    static let horizontalPadding: CGFloat = 14
    static let borderWidth: CGFloat = 1.5
}

struct RoundPillsConfig {
    let titles: [String]
    let activeIndex: Int
}

// Показва трите рунда; активният е жълт, останалите — само контур. Само индикатор.
struct Chips_RoundPills: View {
    let config: RoundPillsConfig

    var body: some View {
        HStack(spacing: RoundPillMetrics.spacing) {
            ForEach(Array(config.titles.enumerated()), id: \.offset) { index, title in
                pill(title, isActive: index == config.activeIndex)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Рундове")
        .accessibilityValue(config.titles.indices.contains(config.activeIndex)
                            ? config.titles[config.activeIndex] : "")
    }

    private func pill(_ title: String, isActive: Bool) -> some View {
        Text(title)
            .font(ApplicationTypography.UIFont_RoundPill)
            .foregroundStyle(isActive
                             ? ApplicationColors.roundPillActiveTextColor
                             : ApplicationColors.roundPillInactiveTextColor)
            .padding(.vertical, RoundPillMetrics.verticalPadding)
            .padding(.horizontal, RoundPillMetrics.horizontalPadding)
            .background {
                if isActive {
                    Capsule().fill(ApplicationColors.roundPillActiveSurfaceColor)
                } else {
                    Capsule().strokeBorder(ApplicationColors.roundPillInactiveBorderColor,
                                           lineWidth: RoundPillMetrics.borderWidth)
                }
            }
    }
}

#Preview {
    ZStack {
        ApplicationColors.darkScreenBackgroundColor.ignoresSafeArea()
        Chips_RoundPills(config: .init(titles: ["Думи", "1 дума", "Мимики"], activeIndex: 0))
    }
    .environment(\.colorScheme, .light)
}
