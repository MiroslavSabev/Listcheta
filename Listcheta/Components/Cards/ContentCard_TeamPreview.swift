//
//  ContentCard_TeamPreview.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 14.09.26.
//

import SwiftUI

struct ContentCard_TeamPreview: View {
    var teamName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(teamName)
                    .font(ApplicationTypography.UIFont_TeamCardTitle)
                    .foregroundStyle(.white)

                Spacer()

                Button(action: {}) {
                    Text("преименувай")
                        .font(ApplicationTypography.UIFont_EditPill)
                        .foregroundStyle(ApplicationColors.teamCardEditTextColor)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 10)
                }
                .frame(maxHeight: 32)
                .background(
                    Capsule()
                        .strokeBorder(ApplicationColors.teamCardEditBorderColor, lineWidth: 1)
                )
            }
            .padding(.horizontal, 18)   // ръчно, само за този ред

            TeamChipsRow(names: ["Мария", "Иво", "Деси", "Мария", "Иво", "Деси", "Мария", "Иво", "Деси"])
                // БЕЗ хоризонтален padding тук — редът заема цялата ширина на картата

            Button(action: {}) {
                Text("+ Добави играч")
                    .font(ApplicationTypography.UIFont_ChipLabel)
                    .foregroundStyle(ApplicationColors.chipAddTextColor)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
            }
            .background(
                Capsule()
                    .fill(ApplicationColors.chipAddSurfaceColor)
            )
            .padding(.horizontal, 18)   // ръчно, само за този бутон
        }
        .padding(.vertical, 18)         // само вертикален padding остава на VStack ниво
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(ApplicationColors.firstTeamSurfaceColor)
        )
    }
}
#Preview {
    struct PreviewWrapper: View {
        @State private var selectedMode = 0
        
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                VStack(spacing: 14) {
                    ContentCard_TeamPreview(teamName: "Розовите")
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
