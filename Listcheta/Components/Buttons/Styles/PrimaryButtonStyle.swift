//
//  PrimaryButtonStyle.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 9.09.26.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    var surfaceColor: Color = Color(ApplicationColors.buttonPrimarySurfaceColor)
    var shadowColor: Color = Color(ApplicationColors.buttonPrimaryShadowSurfaceColor)
    var cornerRadius: CGFloat = 16

    func makeBody(configuration: Self.Configuration) -> some View {

        let pressed = configuration.isPressed && isEnabled

        configuration.label
            .font(ApplicationTypography.UIFont_Body4)
            .foregroundStyle(isEnabled
                             ? Color(ApplicationColors.textTertiaryColor)
                             : ApplicationColors.textPrimaryColor.opacity(0.4))
            .frame(maxWidth: .infinity, maxHeight: 64)
            .background(isEnabled
                        ? surfaceColor
                        : ApplicationColors.textPrimaryColor.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(shadowColor)
                    .offset(y: pressed ? 2 : 6)
                    .opacity(isEnabled ? 1 : 0)
            )
            .offset(y: pressed ? 4 : 0)
            .animation(.easeOut(duration: 0.08), value: configuration.isPressed)
            .animation(.easeOut(duration: 0.15), value: isEnabled)
    }
}
