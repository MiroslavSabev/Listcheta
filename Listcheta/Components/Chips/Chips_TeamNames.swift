//
//  Chips_TeamNames.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 14.09.26.
//


import SwiftUI

// MARK: - Токени за чипа (design-system.html #lists → .chip)
private enum ChipMetrics {
    static let height: CGFloat = 30
    static let hPadding: CGFloat = 12
    static let spacing: CGFloat = 7
    // Смени с точното PostScript име от UIFont.familyNames dump-а ти
    static let font = ApplicationTypography.UIFont_ChipLabel
}

// MARK: - .chip — единичен чип с име, само показва
struct NameChip: View {
    let name: String

    var body: some View {
        Text(name)
            .font(ChipMetrics.font)
            .foregroundStyle(.white)
            .padding(.horizontal, ChipMetrics.hPadding)
            .frame(height: ChipMetrics.height)
            .glassEffect(.clear, in: Capsule())
    }
}

// MARK: - Хоризонтален скрол с чиповете на отбора
struct TeamChipsRow: View {
    let names: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            GlassEffectContainer(spacing: ChipMetrics.spacing) {
                HStack(spacing: ChipMetrics.spacing) {
                    ForEach(names, id: \.self) { name in
                        NameChip(name: name)
                    }
                }
            }
        }
        .contentMargins(18, for: .scrollContent)
    }
}

#Preview {
    ZStack {
        Color(red: 1, green: 0.36, blue: 0.54).ignoresSafeArea() // teamA, само за демо
        TeamChipsRow(names: ["Мария", "Иво", "Деси","Мария", "Иво", "Деси","Мария", "Иво", "Деси"])
            //.padding(.horizontal)
    }
}
