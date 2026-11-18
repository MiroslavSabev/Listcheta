//
//  Mascot_Listko.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 26.10.26.
//

import SwiftUI

// MARK: - Размери (design-system: Листко, стил „Стикер“, viewBox 120 × 135)
private enum ListkoMetrics {
    static let width: CGFloat = 120
    static let height: CGFloat = 135
    static let tilt: Double = 4          // лек наклон, както в дизайна (rotate 4°)
    static let bodyLineWidth: CGFloat = 4
    static let limbLineWidth: CGFloat = 4.5
    static let tapeLineWidth: CGFloat = 2.5
    static let waveArcLineWidth: CGFloat = 2.5
    static let mouthLineWidth: CGFloat = 3.5
}

struct ListkoConfig {
    /// Цветът на тиксото на челото — по него се разпознава към кой отбор е Листко.
    let tapeColor: Color
    /// Огледален вариант: маха с лявата ръка и се накланя наляво (за десния талисман).
    var isMirrored: Bool = false
}

// MARK: - Листко — талисман, който маха. Рисува се с Canvas, без външни асети.
struct Mascot_Listko: View {
    let config: ListkoConfig

    var body: some View {
        Canvas { context, size in
            draw(in: &context, size: size)
        }
        .aspectRatio(ListkoMetrics.width / ListkoMetrics.height, contentMode: .fit)
        .scaleEffect(x: config.isMirrored ? -1 : 1, y: 1)
        .accessibilityHidden(true) // чисто декоративен
    }

    // MARK: Рисуване

    private func draw(in context: inout GraphicsContext, size: CGSize) {
        let scale = min(size.width / ListkoMetrics.width,
                        size.height / ListkoMetrics.height)
        context.scaleBy(x: scale, y: scale)

        // наклон около центъра на тялото
        context.translateBy(x: 60, y: 70)
        context.rotate(by: .degrees(ListkoMetrics.tilt))
        context.translateBy(x: -60, y: -70)

        let outline = ApplicationColors.mascotOutlineColor
        let limb = roundStroke(ListkoMetrics.limbLineWidth)

        // ръце (зад тялото): лявата отпусната, дясната маха
        context.stroke(segment(CGPoint(x: 25, y: 80), CGPoint(x: 12, y: 92)),
                       with: .color(outline), style: limb)
        context.stroke(segment(CGPoint(x: 95, y: 78), CGPoint(x: 110, y: 52)),
                       with: .color(outline), style: limb)

        // дъгичка до махащата ръка
        var wave = Path()
        wave.move(to: CGPoint(x: 114, y: 44))
        wave.addQuadCurve(to: CGPoint(x: 114, y: 57), control: CGPoint(x: 119, y: 50))
        context.stroke(wave, with: .color(outline),
                       style: roundStroke(ListkoMetrics.waveArcLineWidth))

        // крака
        context.stroke(segment(CGPoint(x: 48, y: 110), CGPoint(x: 46, y: 125)),
                       with: .color(outline), style: limb)
        context.stroke(segment(CGPoint(x: 72, y: 110), CGPoint(x: 74, y: 125)),
                       with: .color(outline), style: limb)

        // твърда сянка + тяло
        let shadow = Path(roundedRect: CGRect(x: 30, y: 36, width: 70, height: 80),
                          cornerRadius: 6, style: .continuous)
        let body = Path(roundedRect: CGRect(x: 25, y: 30, width: 70, height: 80),
                        cornerRadius: 6, style: .continuous)
        context.fill(shadow, with: .color(outline))
        context.fill(body, with: .color(ApplicationColors.mascotBodySurfaceColor))
        context.stroke(body, with: .color(outline),
                       style: StrokeStyle(lineWidth: ListkoMetrics.bodyLineWidth, lineJoin: .round))

        // тиксо в цвета на отбора
        let tape = Path(roundedRect: CGRect(x: 44, y: 19, width: 32, height: 15),
                        cornerRadius: 2, style: .continuous)
        context.fill(tape, with: .color(config.tapeColor))
        context.stroke(tape, with: .color(outline),
                       style: StrokeStyle(lineWidth: ListkoMetrics.tapeLineWidth, lineJoin: .round))

        // бузи
        let cheek = ApplicationColors.mascotCheekSurfaceColor
        context.fill(Path(ellipseIn: CGRect(x: 32.5, y: 74.5, width: 11, height: 11)), with: .color(cheek))
        context.fill(Path(ellipseIn: CGRect(x: 76.5, y: 74.5, width: 11, height: 11)), with: .color(cheek))

        // очи + блясък
        context.fill(Path(ellipseIn: CGRect(x: 42.5, y: 58, width: 11, height: 14)), with: .color(outline))
        context.fill(Path(ellipseIn: CGRect(x: 66.5, y: 58, width: 11, height: 14)), with: .color(outline))
        let highlight = ApplicationColors.mascotEyeHighlightColor
        context.fill(Path(ellipseIn: CGRect(x: 48, y: 60, width: 4, height: 4)), with: .color(highlight))
        context.fill(Path(ellipseIn: CGRect(x: 72, y: 60, width: 4, height: 4)), with: .color(highlight))

        // усмивка
        var mouth = Path()
        mouth.move(to: CGPoint(x: 52, y: 78))
        mouth.addQuadCurve(to: CGPoint(x: 68, y: 78), control: CGPoint(x: 60, y: 88))
        context.stroke(mouth, with: .color(outline),
                       style: roundStroke(ListkoMetrics.mouthLineWidth))
    }

    private func roundStroke(_ width: CGFloat) -> StrokeStyle {
        StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round)
    }

    private func segment(_ from: CGPoint, _ to: CGPoint) -> Path {
        var path = Path()
        path.move(to: from)
        path.addLine(to: to)
        return path
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                HStack(spacing: 24) {
                    Mascot_Listko(config: .init(tapeColor: ApplicationColors.firstTeamSurfaceColor))
                        .frame(width: 96)
                    Mascot_Listko(config: .init(tapeColor: ApplicationColors.secondTeamSurfaceColor,
                                                isMirrored: true))
                        .frame(width: 96)
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
