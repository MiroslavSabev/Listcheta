//
//  ActionCard_Mode.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 11.09.26.
//

import SwiftUI

struct ActionCard_Mode: View {
    
    let icon: String
    let title: String
    let description: String
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(alignment: .top, spacing: 14) {
                
                Text(icon)
                    .font(.system(size: 22))
                    .frame(width: 46, height: 46)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(ApplicationColors.backgroundColor)
                    )
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .foregroundStyle(ApplicationColors.textPrimaryColor)
                        .font(ApplicationTypography.UIFont_CardTitle)
                    
                    Text(description)
                        .foregroundStyle(ApplicationColors.textSecondaryColor)
                        .font(ApplicationTypography.UIFont_CardDescription)
                        .lineSpacing(3)
                }
                
                Spacer(minLength: 0)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(isSelected ? ApplicationColors.buttonAccentSurfaceColor.opacity(0.12) : ApplicationColors.textTertiaryColor)
                    .animation(nil, value: isSelected)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .strokeBorder(
                        isSelected ? ApplicationColors.buttonAccentSurfaceColor : .clear,
                        lineWidth: 2
                    )
                    .animation(nil, value: isSelected)
            )
            .shadow(color: ApplicationColors.textPrimaryColor.opacity(0.08), radius: 6, x: 0, y: 4)
        }
        .buttonStyle(CardButtonStyle())
    }
}

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedMode = 0
        
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                VStack(spacing: 14) {
                    ActionCard_Mode(icon: "📱",
                                    title: "Един телефон",
                                    description: "Подавате си телефона един на друг. Не е нужен интернет за други устройства.",
                                    isSelected: selectedMode == 0,
                                    onSelect: { selectedMode = 0 })
                    ActionCard_Mode(
                        icon: "🔗",
                        title: "Всеки на своя телефон",
                        description: "Създава се стая с код. Играчите се включват от собствените си телефони — може и по няколко от едно устройство.",
                        isSelected: selectedMode == 1,
                        onSelect: { selectedMode = 1 }
                    )
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
