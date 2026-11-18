//
//  ExplainerScreen.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 14.11.26.
//

import SwiftUI
internal import Combine

struct ExplainerScreenConfig {
    let word: String
    let roundNumber: Int
    let totalRounds: Int
    /// Пълното име на рунда, напр. "Свободно обяснение".
    let roundTitle: String
    let cardsInBowl: Int
    let scoreThisTurn: Int
    var totalTime: TimeInterval = 60
    var remainingTime: TimeInterval = 60
    var onGotIt: () -> Void = {}
    var onSkip: () -> Void = {}
    var onTimeUp: () -> Void = {}
}

struct ExplainerScreen: View {
    let config: ExplainerScreenConfig

    @State private var timerValue: TimeInterval
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(config: ExplainerScreenConfig) {
        self.config = config
        _timerValue = State(initialValue: config.remainingTime)
    }

    var body: some View {
        ZStack {
            ApplicationColors.darkScreenBackgroundColor.ignoresSafeArea()

            VStack(spacing: 0) {
                roundHeader

                timerView
                    .padding(.top, 14)

                WordSlip(config: .init(word: config.word))
                    .padding(.top, 20)

                statChips
                    .padding(.top, 20)

                Spacer(minLength: 16)

                actionTiles
                    .padding(.bottom, 6) // място за твърдата сянка на плочките
            }
            .padding(.horizontal, 22)
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .navigationBarBackButtonHidden(true)
        .environment(\.colorScheme, .light)
        .onReceive(ticker) { _ in tick() }
    }

    // MARK: - Round header

    private var roundHeader: some View {
        VStack(spacing: 8) {
            Text("РУНД \(config.roundNumber) / \(config.totalRounds)")
                .font(ApplicationTypography.UIFont_RoundNumber)
                .tracking(3.4)
                .foregroundStyle(ApplicationColors.buttonAccentSurfaceColor)

            Text(config.roundTitle)
                .font(ApplicationTypography.UIFont_RoundTitle)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Timer

    private var timerView: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.12), lineWidth: 8)

            Circle()
                .trim(from: 0, to: remainingFraction)
                .stroke(
                    ApplicationColors.buttonAccentSurfaceColor,
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: remainingFraction)

            Text(timeString)
                .font(ApplicationTypography.UIFont_Timer)
                .monospacedDigit()
                .foregroundStyle(Color.white)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
        .frame(width: 120, height: 120)
    }

    private var remainingFraction: Double {
        guard config.totalTime > 0 else { return 0 }
        return max(0, min(1, timerValue / config.totalTime))
    }

    private var timeString: String {
        let total = Int(timerValue)
        return String(format: "%d:%02d", total / 60, total % 60)
    }

    private func tick() {
        guard timerValue > 0 else { return }
        timerValue -= 1
        if timerValue == 0 { config.onTimeUp() }
    }

    // MARK: - Stat chips

    private var statChips: some View {
        HStack(spacing: 8) {
            statChip(label: "В купата",
                     value: "\(config.cardsInBowl)",
                     isHighlighted: false)
            statChip(label: "Този ход",
                     value: "+\(config.scoreThisTurn)",
                     isHighlighted: true)
        }
        .frame(maxWidth: .infinity)
    }

    private func statChip(label: String, value: String, isHighlighted: Bool) -> some View {
        HStack(spacing: 4) {
            Text(label)
                .font(ApplicationTypography.UIFont_StatLabel)
                .foregroundStyle(ApplicationColors.textOnDarkSecondaryColor)
            Text(value)
                .font(ApplicationTypography.UIFont_StatValue)
                .foregroundStyle(isHighlighted
                                 ? ApplicationColors.buttonSuccessSurfaceColor
                                 : Color.white)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(isHighlighted
                      ? ApplicationColors.statChipHighlightSurfaceColor
                      : ApplicationColors.statChipSurfaceColor)
        )
    }

    // MARK: - Action tiles

    private var actionTiles: some View {
        HStack(spacing: 12) {
            Button(action: config.onSkip) {
                tileLabel(icon: "arrow.counterclockwise", title: "Пропусни")
            }
            .buttonStyle(
                ActionTileButtonStyle(
                    surfaceColor: ApplicationColors.buttonHostSurfaceColor,
                    shadowColor: ApplicationColors.buttonHostShadowSurfaceColor,
                    textColor: Color.white
                )
            )

            Button(action: config.onGotIt) {
                tileLabel(icon: "checkmark", title: "Позна!")
            }
            .buttonStyle(
                ActionTileButtonStyle(
                    surfaceColor: ApplicationColors.buttonSuccessSurfaceColor,
                    shadowColor: ApplicationColors.buttonSuccessShadowSurfaceColor,
                    textColor: ApplicationColors.buttonSuccessTextColor
                )
            )
        }
    }

    private func tileLabel(icon: String, title: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(ApplicationTypography.UIFont_TileIcon)
            Text(title)
                .font(ApplicationTypography.UIFont_TileLabel)
        }
    }
}

// MARK: - Button Style

/// Квадратна плочка с твърда сянка. И двете плочки са с еднакъв размер (96pt),
/// различават се само по цвят.
struct ActionTileButtonStyle: ButtonStyle {

    var surfaceColor: Color
    var shadowColor: Color
    var textColor: Color
    var cornerRadius: CGFloat = 22

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 96)
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

#Preview {
    NavigationStack {
        ExplainerScreen(config: .init(
            word: "пеперуда",
            roundNumber: 1,
            totalRounds: 3,
            roundTitle: "Свободно обяснение",
            cardsInBowl: 14,
            scoreThisTurn: 3,
            remainingTime: 42
        ))
    }
}
