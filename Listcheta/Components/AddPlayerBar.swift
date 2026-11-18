//
//  AddPlayerBar.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 31.10.26.
//

import SwiftUI

// Поле за име + два бутона за отбор. Докосването на цвета е „запази“ и „избери отбор“ наведнъж.
// first  = 🩷 Розовите  (ляв лист)
// second = 🌊 Тюркоазите (десен лист)
struct AddPlayerBar: View {
    @Binding var draft: String
    let onAddToFirst: () -> Void
    let onAddToSecond: () -> Void

    @FocusState private var isFocused: Bool

    private var isEmpty: Bool {
        draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack(spacing: 8) {
            TextField("Име на играч…", text: $draft)
                .font(ApplicationTypography.UIFont_Body3)
                .focused($isFocused)
                .submitLabel(.done)
                .autocorrectionDisabled()
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(ApplicationColors.textTertiaryColor)
                )

            teamButton(emoji: "🩷",
                       color: ApplicationColors.secondTeamSurfaceColor,
                       action: onAddToFirst)
            teamButton(emoji: "🌊",
                       color: ApplicationColors.firstTeamSurfaceColor,
                       action: onAddToSecond)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.bar)
        .task { isFocused = true }
    }

    private func teamButton(emoji: String, color: Color, action: @escaping () -> Void) -> some View {
        Button {
            action()
            isFocused = true          // клавиатурата остава отворена
        } label: {
            Text("\(emoji) +")
                .font(ApplicationTypography.UIFont_ChipLabel)
                .foregroundStyle(.white)
                .frame(width: 58, height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous).fill(color)
                )
        }
        .buttonStyle(.plain)
        .opacity(isEmpty ? 0.35 : 1)
        .disabled(isEmpty)
        .animation(.easeOut(duration: 0.12), value: isEmpty)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var draft = "Лора"
        var body: some View {
            ZStack(alignment: .bottom) {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                AddPlayerBar(draft: $draft, onAddToFirst: {}, onAddToSecond: {})
            }
        }
    }
    return PreviewWrapper()
}
