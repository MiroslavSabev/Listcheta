//
//  ContentCard_TeamSheet.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 31.10.26.
//

import SwiftUI

// MARK: - Токени (design: .sheet / .lines в „А2 — предложение 1“)
private enum TeamSheetMetrics {
    static let cornerRadius: CGFloat = 6
    static let rowHeight: CGFloat = 40
    static let minRows = 4              // празните редове пазят листа от „скачане“
    static let tapeSize = CGSize(width: 54, height: 18)
    static let tapeTilt: Double = -2
}

struct TeamSheetConfig {
    let title: String
    let titleColor: Color
    /// Цветът на тиксото — по него се разпознава отборът.
    let tapeColor: Color
    let players: [TeamPlayer]
    /// Лек наклон на листа (градуси) — „хартиено“ усещане.
    var tilt: Double = 0
    var onRemove: (TeamPlayer) -> Void = { _ in }
}

// MARK: - Листче с играчите на отбора — само показва, добавянето е в AddPlayerBar
struct ContentCard_TeamSheet: View {
    let config: TeamSheetConfig

    private var emptyRows: Int {
        max(0, TeamSheetMetrics.minRows - config.players.count)
    }

    var body: some View {
        VStack(spacing: 6) {
            Text(config.title)
                .font(ApplicationTypography.UIFont_SheetTitle)
                .foregroundStyle(config.titleColor)

            VStack(spacing: 0) {
                ForEach(config.players) { player in
                    playerRow(player)
                        .transition(.opacity)
                }
                ForEach(0..<emptyRows, id: \.self) { index in
                    emptyRow(showsHint: config.players.isEmpty && index == 0)
                }
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 12)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: TeamSheetMetrics.cornerRadius, style: .continuous)
                .fill(ApplicationColors.sheetSurfaceColor)
                .shadow(color: ApplicationColors.sheetShadowColor, radius: 10, x: 0, y: 8)
        )
        .overlay(alignment: .top) {
            tape.offset(y: -TeamSheetMetrics.tapeSize.height / 2)
        }
        .rotationEffect(.degrees(config.tilt))
    }

    // MARK: Части

    private var tape: some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .fill(config.tapeColor.opacity(0.9))
            .frame(width: TeamSheetMetrics.tapeSize.width,
                   height: TeamSheetMetrics.tapeSize.height)
            .rotationEffect(.degrees(TeamSheetMetrics.tapeTilt))
    }

    private var ruledLine: some View {
        Rectangle()
            .fill(ApplicationColors.sheetLineColor)
            .frame(height: 1)
    }

    private func playerRow(_ player: TeamPlayer) -> some View {
        HStack(spacing: 4) {
            Text(player.name)
                .font(ApplicationTypography.UIFont_SheetName)
                .foregroundStyle(ApplicationColors.textPrimaryColor)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Spacer(minLength: 0)

            Button {
                config.onRemove(player)
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(ApplicationColors.sheetRemoveColor)
                    .frame(width: 44, height: TeamSheetMetrics.rowHeight)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Премахни \(player.name)")
        }
        .frame(height: TeamSheetMetrics.rowHeight)
        .overlay(alignment: .bottom) { ruledLine }
    }

    private func emptyRow(showsHint: Bool) -> some View {
        HStack {
            if showsHint {
                Text("още никой…")
                    .font(ApplicationTypography.UIFont_SheetName)
                    .foregroundStyle(ApplicationColors.sheetEmptyTextColor)
            }
            Spacer(minLength: 0)
        }
        .frame(height: TeamSheetMetrics.rowHeight)
        .overlay(alignment: .bottom) { ruledLine }
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                HStack(alignment: .top, spacing: 12) {
                    ContentCard_TeamSheet(config: .init(
                        title: "🩷 Розовите",
                        titleColor: ApplicationColors.secondTeamTitleColor,
                        tapeColor: ApplicationColors.secondTeamSurfaceColor,
                        players: [TeamPlayer(name: "Мария"), TeamPlayer(name: "Иво"), TeamPlayer(name: "Деси")],
                        tilt: -1.2))
                    ContentCard_TeamSheet(config: .init(
                        title: "🌊 Тюркоазите",
                        titleColor: ApplicationColors.firstTeamTitleColor,
                        tapeColor: ApplicationColors.firstTeamSurfaceColor,
                        players: [],
                        tilt: 1.2))
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
