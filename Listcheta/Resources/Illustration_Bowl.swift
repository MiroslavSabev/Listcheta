//
//  Illustration_Bowl.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 24.10.26.
//

import SwiftUI

// MARK: - Токени (master-design2.html → .bowl / .bowl .b / .mini)
private enum BowlMetrics {
    static let width: CGFloat = 180
    static let height: CGFloat = 136
    static let bowlHeight: CGFloat = 82
    static let bowlShadeHeight: CGFloat = 12
    static let slipWidth: CGFloat = 52
    static let slipHeight: CGFloat = 32
    static let slipCornerRadius: CGFloat = 4
}

private struct SlipLayout {
    let x: CGFloat
    let y: CGFloat
    let angle: Double
    let isHighlighted: Bool
}

// Купата с листчета — декоративна илюстрация, без взаимодействие.
struct Illustration_Bowl: View {
    var words: [String] = ["котка", "луна", "море"]

    // top/left/right от дизайна, преобразувани в x/y от горния ляв ъгъл
    private let layouts: [SlipLayout] = [
        .init(x: 14,  y: 6,  angle: -9, isHighlighted: false),
        .init(x: 120, y: -2, angle: 7,  isHighlighted: false),
        .init(x: 64,  y: 36, angle: 3,  isHighlighted: true)
    ]

    private var bowlShape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(bottomLeadingRadius: BowlMetrics.width / 2,
                               bottomTrailingRadius: BowlMetrics.width / 2,
                               style: .continuous)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach(Array(zip(words, layouts).enumerated()), id: \.offset) { _, item in
                slip(item.0, layout: item.1)
            }
            bowl
        }
        .frame(width: BowlMetrics.width,
               height: BowlMetrics.height,
               alignment: .topLeading)
        .accessibilityHidden(true)
    }

    private func slip(_ word: String = "", layout: SlipLayout) -> some View {
        Text("")
            .font(ApplicationTypography.UIFont_BowlSlip)
            .foregroundStyle(ApplicationColors.textPrimaryColor)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .frame(width: BowlMetrics.slipWidth, height: BowlMetrics.slipHeight)
            .background(
                RoundedRectangle(cornerRadius: BowlMetrics.slipCornerRadius, style: .continuous)
                    .fill(layout.isHighlighted
                          ? ApplicationColors.buttonAccentSurfaceColor
                          : ApplicationColors.textTertiaryColor)
            )
            .shadow(color: ApplicationColors.bowlSlipShadowColor, radius: 5, x: 0, y: 4)
            .rotationEffect(.degrees(layout.angle))
            .offset(x: layout.x, y: layout.y)
    }

    private var bowl: some View {
        bowlShape
            .fill(ApplicationColors.bowlSurfaceColor)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(ApplicationColors.bowlShadeColor)
                    .frame(height: BowlMetrics.bowlShadeHeight)
            }
            .clipShape(bowlShape)
            .frame(width: BowlMetrics.width, height: BowlMetrics.bowlHeight)
            .offset(y: BowlMetrics.height - BowlMetrics.bowlHeight)
    }
}

#Preview {
    ZStack {
        ApplicationColors.darkScreenBackgroundColor.ignoresSafeArea()
        Illustration_Bowl()
    }
    .environment(\.colorScheme, .light)
}
