//
//  Indicator_WaitNote.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 27.10.26.
//

import SwiftUI

// design-system.html #scoring → .waitnote (spinner + muted текст)
struct Indicator_WaitNote: View {
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            ProgressView()
                .controlSize(.small)
                .tint(ApplicationColors.textPrimaryColor)

            Text(text)
                .font(ApplicationTypography.UIFont_WaitNote)
                .foregroundStyle(ApplicationColors.textSecondaryColor)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                Indicator_WaitNote(text: "Домакинът стартира Рунд 2…")
                    .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
