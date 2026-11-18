//
//  ContentCard_TrophySlip.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 15.11.26.
//

import SwiftUI

// MARK: - Токени (design-system.html #finale → .trophyslip)
private enum TrophySlipMetrics {
    static let width: CGFloat = 190
    static let cornerRadius: CGFloat = 6
    static let topPadding: CGFloat = 26
    static let horizontalPadding: CGFloat = 14
    static let bottomPadding: CGFloat = 22
    static let cupSize: CGFloat = 44
    static let nameTopSpacing: CGFloat = 4
    static let tilt: Double = 2
    static let tapeWidth: CGFloat = 64
    static let tapeHeight: CGFloat = 20
    static let tapeOffset: CGFloat = -9
    static let tapeTilt: Double = -2
}

struct TrophySlipConfig {
    let teamName: String
}

// MARK: - .trophyslip — листче с трофей и името на победителя
struct ContentCard_TrophySlip: View {
    let config: TrophySlipConfig

    var body: some View {
        VStack(spacing: TrophySlipMetrics.nameTopSpacing) {
            Text("🏆")
                .font(.system(size: TrophySlipMetrics.cupSize))

            Text(config.teamName)
                .font(ApplicationTypography.UIFont_TrophyTeamName)
                .foregroundStyle(ApplicationColors.trophySlipTextColor)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.8)
                .lineLimit(2)
        }
        .padding(.top, TrophySlipMetrics.topPadding)
        .padding(.horizontal, TrophySlipMetrics.horizontalPadding)
        .padding(.bottom, TrophySlipMetrics.bottomPadding)
        .frame(width: TrophySlipMetrics.width)
        .background(
            RoundedRectangle(cornerRadius: TrophySlipMetrics.cornerRadius, style: .continuous)
                .fill(ApplicationColors.trophySlipSurfaceColor)
                .shadow(color: ApplicationColors.textPrimaryColor.opacity(0.16),
                        radius: 11, x: 0, y: 8)
        )
        .overlay(alignment: .top) { tape }
        .rotationEffect(.degrees(TrophySlipMetrics.tilt))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Победител")
        .accessibilityValue(config.teamName)
    }

    private var tape: some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .fill(ApplicationColors.trophySlipTapeColor)
            .frame(width: TrophySlipMetrics.tapeWidth,
                   height: TrophySlipMetrics.tapeHeight)
            .rotationEffect(.degrees(TrophySlipMetrics.tapeTilt))
            .offset(y: TrophySlipMetrics.tapeOffset)
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.finaleBackgroundBottomColor.ignoresSafeArea()
                ContentCard_TrophySlip(config: .init(teamName: "Розовите"))
                    .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
