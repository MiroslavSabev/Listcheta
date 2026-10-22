//
//  Indicator_ProgressDots.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 11.10.26.
//


import SwiftUI

// design-system.html #lists → .dots / .dot / .dot.on  (височина 5pt · radius 4 · gap 5)
// Точките делят равно цялата налична ширина — колкото и да са на брой.
struct Indicator_ProgressDots: View {
    let total: Int
    let filled: Int

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<total, id: \.self) { index in
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(index < filled
                          ? ApplicationColors.progressDotOnColor
                          : ApplicationColors.progressDotOffColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 5)
            }
        }
        .frame(maxWidth: .infinity)
        .animation(.easeOut(duration: 0.15), value: filled)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Написани думи")
        .accessibilityValue("\(filled) от \(total)")
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                Indicator_ProgressDots(total: 10, filled: 4)
                    .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
