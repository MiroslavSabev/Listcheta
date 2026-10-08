//
//  AccentButtonStyle.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 1.09.26.
//

import SwiftUI

struct AccentButtonStyle: ButtonStyle {
    
    var surfaceColor: Color = Color(ApplicationColors.buttonAccentSurfaceColor)
    var shadowColor: Color = Color(ApplicationColors.buttonAccentShadowSurfaceColor)
    var cornerRadius: CGFloat = 16
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        configuration.label
            .font(ApplicationTypography.UIFont_Body4)
            .foregroundStyle(Color(ApplicationColors.textPrimaryColor))
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
