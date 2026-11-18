//
//  WordSlip.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 14.11.26.
//

import SwiftUI

struct WordSlipConfig {
    let word: String
    var isRotated: Bool = true
    var rotationDegrees: Double = -1.5
}

struct WordSlip: View {
    let config: WordSlipConfig
    
    var body: some View {
        Text(config.word)
            .font(ApplicationTypography.UIFont_SheetName)
            .foregroundStyle(ApplicationColors.textPrimaryColor)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(.horizontal, 20)
            .padding(.vertical, 36)
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(ApplicationColors.textTertiaryColor)
                    .overlay(
                        GeometryReader { geo in
                            Path { path in
                                let width = geo.size.width
                                let height = geo.size.height
                                let centerX = width / 2
                                let topY: CGFloat = -9
                                let rectWidth: CGFloat = 64
                                let rectHeight: CGFloat = 20
                                let cornerRadius: CGFloat = 2
                                
                                path.addRoundedRect(
                                    in: CGRect(
                                        x: centerX - rectWidth / 2,
                                        y: topY,
                                        width: rectWidth,
                                        height: rectHeight
                                    ),
                                    cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
                                )
                            }
                            .fill(ApplicationColors.buttonAccentSurfaceColor.opacity(0.75))
                            .rotationEffect(.degrees(-2), anchor: .center)
                        }
                    )
            )
            .shadow(color: ApplicationColors.sheetShadowColor, radius: 22, x: 0, y: 8)
            .rotationEffect(.degrees(config.isRotated ? config.rotationDegrees : 0))
    }
}

#Preview {
    ZStack {
        ApplicationColors.darkScreenBackgroundColor.ignoresSafeArea()
        WordSlip(config: .init(word: "пеперуда"))
    }
    .environment(\.colorScheme, .light)
}