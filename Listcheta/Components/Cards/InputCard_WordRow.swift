//
//  InputCard_WordRow.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 8.10.26.
//

import SwiftUI

struct WordRowConfig {
    let number: Int
    var placeholder: String = "напиши дума…"
}

struct InputCard_WordRow: View {
    let config: WordRowConfig
    @Binding var text: String
    var focus: FocusState<Int?>.Binding      // ново
    var onSubmit: () -> Void = {}

    private var index: Int { config.number - 1 }   // ново

    // ❌ изтрий: @FocusState private var isFocused: Bool

    private var isEmpty: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack(spacing: 10) {
            Text(String(format: "%02d", config.number))
                .font(ApplicationTypography.UIFont_WordRowNumber)
                .foregroundStyle(ApplicationColors.textSecondaryColor)

            TextField("",
                      text: $text,
                      prompt: Text(config.placeholder)
                        .foregroundColor(ApplicationColors.textPrimaryColor.opacity(0.28)),
                      axis: .vertical)
                .lineLimit(1...3)   // при lineLimit(1) Return може пак да изпраща полето
                .font(ApplicationTypography.UIFont_WordRowInput)
                .foregroundStyle(ApplicationColors.textPrimaryColor)
                .focused(focus, equals: index)
                .submitLabel(.next)
                .autocorrectionDisabled()
                .onChange(of: text) { _, newValue in
                    if newValue.contains("\n") {
                        text = newValue.replacingOccurrences(of: "\n", with: "")
                        onSubmit()
                    }
                }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(ApplicationColors.textTertiaryColor) // paper
                .animation(nil, value: isEmpty)
        )
        .shadow(color: ApplicationColors.textPrimaryColor.opacity(0.08),
                radius: 4, x: 0, y: 3)
        .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .onTapGesture { focus.wrappedValue = index }    // ← вместо isFocused = true
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var words = ["хладилник", "пеперуда", "космонавт", "баница", ""]
        @FocusState private var focus: Int?
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                VStack(spacing: 8) {
                    ForEach(words.indices, id: \.self) { i in
                        InputCard_WordRow(config: .init(number: i + 1),
                                          text: $words[i],
                                          focus: $focus)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
