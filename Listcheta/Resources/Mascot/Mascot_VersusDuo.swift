//
//  Mascot_VersusDuo.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 26.10.26.
//

import SwiftUI

// MARK: - Размери (design-system: екран А1, разделител между плочките на отборите)
private enum VersusDuoMetrics {
    static let rowHeight: CGFloat = 74
    static let mascotWidth: CGFloat = 72
    static let horizontalInset: CGFloat = 50
    static let labelTracking: CGFloat = 1.1
}

struct VersusDuoConfig {
    /// Цвят на тиксото на левия Листко (отборът от плочката отгоре).
    let firstTapeColor: Color
    /// Цвят на тиксото на десния Листко (отборът от плочката отдолу).
    let secondTapeColor: Color
    var versusText: String = "VS"
}

// MARK: - Двама Листко, които си махат между плочките на отборите
struct Mascot_VersusDuo: View {
    let config: VersusDuoConfig

    var body: some View {
        HStack(spacing: 0) {
            Mascot_Listko(config: .init(tapeColor: config.firstTapeColor))
                .frame(width: VersusDuoMetrics.mascotWidth)

            Spacer(minLength: 8)

            Text(config.versusText)
                .font(ApplicationTypography.UIFont_VersusLabel)
                .tracking(VersusDuoMetrics.labelTracking)
                .foregroundStyle(ApplicationColors.textSecondaryColor)

            Spacer(minLength: 8)

            Mascot_Listko(config: .init(tapeColor: config.secondTapeColor, isMirrored: true))
                .frame(width: VersusDuoMetrics.mascotWidth)
        }
        .padding(.horizontal, VersusDuoMetrics.horizontalInset)
        .frame(maxWidth: .infinity)
        .frame(height: VersusDuoMetrics.rowHeight)
        .accessibilityElement(children: .ignore)
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(ApplicationColors.firstTeamSurfaceColor)
                        .frame(height: 120)
                    Mascot_VersusDuo(config: .init(firstTapeColor: ApplicationColors.firstTeamSurfaceColor,
                                                   secondTapeColor: ApplicationColors.secondTeamSurfaceColor))
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(ApplicationColors.secondTeamSurfaceColor)
                        .frame(height: 120)
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
