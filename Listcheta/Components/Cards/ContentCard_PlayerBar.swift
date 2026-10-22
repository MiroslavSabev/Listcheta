//
//  ContentCard_PlayerBar.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 11.10.26.
//


import SwiftUI

struct PlayerBarConfig {
    let initial: String
    let title: String
    let subtitle: String
    let avatarColor: Color
}

struct ContentCard_PlayerBar: View {
    let config: PlayerBarConfig

    var body: some View {
        HStack(spacing: 12) {
            avatar
            texts
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var avatar: some View {
        Circle()
            .fill(config.avatarColor)
            .frame(width: 44, height: 44)
            .overlay(
                Text(config.initial)
                    .font(ApplicationTypography.UIFont_PlayerBarAvatar)
                    .foregroundStyle(ApplicationColors.avatarTextColor)
            )
    }

    private var texts: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(config.title)
                .font(ApplicationTypography.UIFont_PlayerBarName)
                .foregroundStyle(ApplicationColors.textPrimaryColor)

            Text(config.subtitle)
                .font(ApplicationTypography.UIFont_PlayerBarSub)
                .foregroundStyle(ApplicationColors.textSecondaryColor)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                ContentCard_PlayerBar(
                    config: .init(initial: "И",
                                  title: "Иво пише думите си",
                                  subtitle: "Само съществителни · никой друг не гледа 🙈",
                                  avatarColor: ApplicationColors.firstTeamSurfaceColor)
                )
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
