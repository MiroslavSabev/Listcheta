//
//  ContentCard_Rule.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 17.11.26.
//

import SwiftUI

struct RuleCardConfig {
    let badge: String
    let title: String
    let description: String
    let badgeSurfaceColor: Color
    var badgeTextColor: Color = ApplicationColors.ruleBadgeLightTextColor
}

// design-system.html #cards → .rulecard
struct ContentCard_Rule: View {
    let config: RuleCardConfig

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            badge
            texts
            Spacer(minLength: 0)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(ApplicationColors.ruleCardSurfaceColor)
        )
        .shadow(color: ApplicationColors.textPrimaryColor.opacity(0.08),
                radius: 6, x: 0, y: 4)
        .accessibilityElement(children: .combine)
    }

    private var badge: some View {
        Text(config.badge)
            .font(ApplicationTypography.UIFont_RuleNumber)
            .foregroundStyle(config.badgeTextColor)
            .frame(width: 34, height: 34)
            .background(
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .fill(config.badgeSurfaceColor)
            )
    }

    private var texts: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(config.title)
                .font(ApplicationTypography.UIFont_RuleTitle)
                .foregroundStyle(ApplicationColors.textPrimaryColor)

            Text(config.description)
                .font(ApplicationTypography.UIFont_RuleDescription)
                .foregroundStyle(ApplicationColors.ruleCardDescriptionColor)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                ContentCard_Rule(config: .init(
                    badge: "1",
                    title: "Свободно обяснение",
                    description: "Описвай думата с други думи. Забранено е да използваш корена ѝ.",
                    badgeSurfaceColor: ApplicationColors.ruleBadgeFirstSurfaceColor))
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
