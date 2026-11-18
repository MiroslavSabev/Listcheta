//
//  Decoration_Confetti.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 15.11.26.
//

import SwiftUI

// MARK: - Токени (design-system.html #finale → .confetti i)
private enum ConfettiMetrics {
    static let pieceWidth: CGFloat = 8
    static let pieceHeight: CGFloat = 14
    static let cornerRadius: CGFloat = 2
    static let opacity: Double = 0.9
}

private struct ConfettiPiece: Identifiable {
    let id: Int
    let x: CGFloat      // дял от ширината на екрана (0…1)
    let y: CGFloat      // pt от горния ръб на екрана
    let angle: Double
    let color: Color
}

private let confettiPieces: [ConfettiPiece] = [
    .init(id: 0, x: 0.125, y: 70,  angle: 20,  color: ApplicationColors.confettiPinkColor),
    .init(id: 1, x: 0.82,  y: 110, angle: -30, color: ApplicationColors.confettiSunColor),
    .init(id: 2, x: 0.25,  y: 160, angle: 50,  color: ApplicationColors.confettiTealColor),
    .init(id: 3, x: 0.63,  y: 90,  angle: 10,  color: ApplicationColors.confettiWhiteColor),
    .init(id: 4, x: 0.76,  y: 190, angle: -15, color: ApplicationColors.confettiPinkColor),
    .init(id: 5, x: 0.09,  y: 150, angle: 70,  color: ApplicationColors.confettiSunColor)
]

// MARK: - .confetti — декоративни конфети по горната част на финалния екран
struct Decoration_Confetti: View {

    var body: some View {
        GeometryReader { proxy in
            ForEach(confettiPieces) { piece in
                RoundedRectangle(cornerRadius: ConfettiMetrics.cornerRadius, style: .continuous)
                    .fill(piece.color)
                    .frame(width: ConfettiMetrics.pieceWidth,
                           height: ConfettiMetrics.pieceHeight)
                    .opacity(ConfettiMetrics.opacity)
                    .rotationEffect(.degrees(piece.angle))
                    .position(x: proxy.size.width * piece.x + ConfettiMetrics.pieceWidth / 2,
                              y: piece.y + ConfettiMetrics.pieceHeight / 2)
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}

#Preview {
    ZStack {
        ApplicationColors.finaleBackgroundBottomColor.ignoresSafeArea()
        Decoration_Confetti().ignoresSafeArea()
    }
}
