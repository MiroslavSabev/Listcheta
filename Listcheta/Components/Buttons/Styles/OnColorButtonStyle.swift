//
//  OnColorButtonStyle.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 2.11.26.
//

import SwiftUI

// design-system.html #buttons → White-on-color (handoff бутон)
// Бял фон, текстът взима цвета на екрана; сянката е неутрално черно 20%.
struct OnColorButtonStyle: ButtonStyle {

    let textColor: Color
    var surfaceColor: Color = ApplicationColors.buttonOnColorSurfaceColor
    var shadowColor: Color = ApplicationColors.buttonOnColorShadowSurfaceColor
    var cornerRadius: CGFloat = 16

    func makeBody(configuration: Self.Configuration) -> some View {

        configuration.label
            .font(ApplicationTypography.UIFont_Body4)
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity, maxHeight: 64)
            .background(surfaceColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(shadowColor)
                    .offset(y: configuration.isPressed ? 2 : 6)
            )
            .offset(y: configuration.isPressed ? 4 : 0)
            .animation(.easeOut(duration: 0.08), value: configuration.isPressed)
    }
}
