//
//  ContentCard_PlayerHandoff.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 2.11.26.
//

import SwiftUI

struct PlayerHandoffConfig {
    /// Име на играча, който е на ред („Мария“).
    let playerName: String
    /// Етикет под името („ОТБОР РОЗОВИТЕ“).
    let teamTitle: String
    /// Цветът на отбора — цвят на инициала в аватара и на бутона.
    let teamColor: Color
    /// Пренесено време от миналия рунд („0:23“). nil → няма бележка.
    var carriedTime: String? = nil
}

// design-system.html #players → .bigavatar / .s5-who / .s5-team · #cards → .carrynote
struct ContentCard_PlayerHandoff: View {
    let config: PlayerHandoffConfig

    var body: some View {
        VStack(spacing: 0) {
            Text("НА РЕД Е")
                .font(ApplicationTypography.UIFont_Eyebrow)
                .foregroundStyle(ApplicationColors.onColorEyebrowTextColor)
                .tracking(3)

            avatar
                .padding(.top, 18)

            Text(config.playerName)
                .font(ApplicationTypography.UIFont_HandoffName)
                .foregroundStyle(ApplicationColors.onColorTextColor)
                .multilineTextAlignment(.center)
                .padding(.top, 12)

            Text(config.teamTitle)
                .font(ApplicationTypography.UIFont_HandoffTeam)
                .foregroundStyle(ApplicationColors.onColorTextColor.opacity(0.9))
                .tracking(0.8)
                .padding(.top, 8)

            if let time = config.carriedTime {
                carryNote(time: time)
                    .padding(.top, 24)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var avatar: some View {
        Circle()
            .fill(ApplicationColors.onColorAvatarSurfaceColor)
            .frame(width: 100, height: 100)
            .overlay(
                Text(String(config.playerName.prefix(1)).uppercased())
                    .font(ApplicationTypography.UIFont_HandoffAvatar)
                    .foregroundStyle(config.teamColor)
            )
            .shadow(color: ApplicationColors.avatarShadowColor, radius: 18, x: 0, y: 16)
            .accessibilityHidden(true)
    }

    private func carryNote(time: String) -> some View {
        (Text("⏱ Имаш пренесени ")
            .font(ApplicationTypography.UIFont_HandoffNote)
         + Text(time)
            .font(ApplicationTypography.UIFont_HandoffNoteBold)
         + Text(" от миналия рунд — таймерът продължава оттам.")
            .font(ApplicationTypography.UIFont_HandoffNote))
        .foregroundStyle(ApplicationColors.onColorTextColor)
        .multilineTextAlignment(.center)
        .lineSpacing(3)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: 282)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(ApplicationColors.onColorNoteSurfaceColor)
        )
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.firstTeamSurfaceColor.ignoresSafeArea()
                ContentCard_PlayerHandoff(
                    config: .init(playerName: "Мария",
                                  teamTitle: "ОТБОР РОЗОВИТЕ",
                                  teamColor: ApplicationColors.firstTeamSurfaceColor,
                                  carriedTime: "0:23")
                )
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
