//
//  ContentCard_Handoff.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 24.10.26.
//

import SwiftUI

private enum HandoffMetrics {
    static let topPadding: CGFloat = 16
    static let dividerWidth: CGFloat = 1.5
    static let spacing: CGFloat = 6
}

struct HandoffConfig {
    let label: String
    let name: String
    var accentText: String? = nil
}

struct ContentCard_Handoff: View {
    let config: HandoffConfig

    var body: some View {
        VStack(spacing: HandoffMetrics.spacing) {
            Text(config.label)
                .font(ApplicationTypography.UIFont_HandoffLabel)
                .foregroundStyle(ApplicationColors.textOnDarkSecondaryColor)

            nameText
        }
        .padding(.top, HandoffMetrics.topPadding)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(ApplicationColors.dividerOnDarkColor)
                .frame(height: HandoffMetrics.dividerWidth)
        }
        .accessibilityElement(children: .combine)
    }

    private var nameText: Text {
        let name = Text(config.name)
            .font(ApplicationTypography.UIFont_HandoffName)
            .foregroundStyle(ApplicationColors.textOnDarkPrimaryColor)
        guard let accent = config.accentText else { return name }
        return Text("\(name) \(accent)")
                .font(ApplicationTypography.UIFont_HandoffName)
                .foregroundStyle(ApplicationColors.handoffAccentColor)
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.darkScreenBackgroundColor.ignoresSafeArea()
                VStack(spacing: 32) {
                    ContentCard_Handoff(config: .init(label: "Първи обяснява", name: "Иван"))
                    ContentCard_Handoff(config: .init(label: "Продължава с оставащото време",
                                                      name: "Мария",
                                                      accentText: "· 0:23"))
                }
                .padding(.horizontal, 24)
            }
            .environment(\.colorScheme, .light)
        }
    }
    return PreviewWrapper()
}
