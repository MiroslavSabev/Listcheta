//
//  GhostButtonStyle.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 9.09.26.
//

import SwiftUI

struct GhostButtonStyle: ButtonStyle {
    
    var surfaceColor: Color = .clear
    var borderColor: Color = Color(ApplicationColors.buttonGhostBorderColor)
    var textColor: Color = Color(ApplicationColors.textPrimaryColor)
    var cornerRadius: CGFloat = 16
    var borderWidth: CGFloat = 2
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(ApplicationTypography.UIFont_Body4)
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity, maxHeight: 64)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius,
                                 style: .continuous)
                    .strokeBorder(borderColor, lineWidth: borderWidth)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius,
                                         style: .continuous)
                            .fill(surfaceColor)
                    )
            )
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}


#Preview {
    StartupView()
}
