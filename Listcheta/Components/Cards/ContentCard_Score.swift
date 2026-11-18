//
//  ContentCard_Score.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 27.10.26.
//

import SwiftUI

// design-system.html #scoring → .scorecard (radius 20 · пад. 16/18)
struct ScoreCardConfig {
    let teamName: String
    let subtitle: String
    let points: Int
    let surfaceColor: Color
}

struct ContentCard_Score: View {
    let config: ScoreCardConfig

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(config.teamName)
                    .font(ApplicationTypography.UIFont_ScoreCardTitle)
                    .foregroundStyle(ApplicationColors.scoreCardTextColor)

                Text(config.subtitle)
                    .font(ApplicationTypography.UIFont_ScoreCardSubtitle)
                    .foregroundStyle(ApplicationColors.scoreCardSubtitleColor)
            }

            Spacer(minLength: 0)

            Text("\(config.points)")
                .font(ApplicationTypography.UIFont_ScoreCardPoints)
                .foregroundStyle(ApplicationColors.scoreCardTextColor)
                .monospacedDigit()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(config.surfaceColor)
        )
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                VStack(spacing: 12) {
                    ContentCard_Score(config: .init(teamName: "🩷 Розовите",
                                                    subtitle: "+12 листчета този рунд",
                                                    points: 12,
                                                    surfaceColor: ApplicationColors.secondTeamSurfaceColor))
                    ContentCard_Score(config: .init(teamName: "🌊 Тюркоазите",
                                                    subtitle: "+8 листчета този рунд",
                                                    points: 8,
                                                    surfaceColor: ApplicationColors.firstTeamSurfaceColor))
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
