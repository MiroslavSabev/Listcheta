//
//  WordSlip.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 14.11.26.
//

import SwiftUI

struct WordSlipConfig {
    let word: String
    /// 0 = без завъртане. В дизайна листчето е завъртяно с -1.5°.
    var rotationDegrees: Double = -1.5
}

struct WordSlip: View {
    let config: WordSlipConfig

    var body: some View {
        Text(config.word)
            .font(ApplicationTypography.UIFont_SheetName2)
            .foregroundStyle(ApplicationColors.textPrimaryColor)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity)          // пълна ширина, като .gameslip { width:100% }
            .padding(.vertical, 36)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(ApplicationColors.textTertiaryColor) // paper
            )
            .overlay(alignment: .top) { tape }
            .shadow(color: ApplicationColors.sheetShadowColor, radius: 11, x: 0, y: 8)
            .rotationEffect(.degrees(config.rotationDegrees))
    }

    /// Тиксото: 64×20, -2°, излиза 9pt над листчето.
    private var tape: some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .fill(ApplicationColors.buttonAccentSurfaceColor.opacity(0.75))
            .frame(width: 64, height: 20)
            .rotationEffect(.degrees(-2))
            .offset(y: -9)
    }
}

#Preview {
    ZStack {
        ApplicationColors.darkScreenBackgroundColor.ignoresSafeArea()
        WordSlip(config: .init(word: "пеперуда"))
            .padding(.horizontal, 20)
    }
    .environment(\.colorScheme, .light)
}
