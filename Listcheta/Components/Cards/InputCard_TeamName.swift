//
//  InputCard_TeamName.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.09.26.
//

import SwiftUI

struct TeamCardConfig {
    let title: String
    let surfaceColor: Color
    let suggestions: [String]
}

struct InputCard_TeamName: View {
    let config: TeamCardConfig
    
    @Binding var teamName: String
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
  
            cardTitle
            textField
            suggestionsChips
        }
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(config.surfaceColor)
        )
    }
    
    private var cardTitle: some View {
        Text(config.title)
            .font(ApplicationTypography.UIFont_TeamCardTitle)
            .foregroundStyle(.white)
            .padding(.horizontal)
    }
    
    private var textField: some View {
        TextField("Име",
                  text: $teamName)
        .font(ApplicationTypography.UIFont_Body3)
        .padding()
        .focused(isFocused)
        .onSubmit {
        }
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.white)
        )
        .padding(.horizontal,12)
    }
    
    private var suggestionsChips: some View {
        HStack(spacing: 12) {
            
            Button(action: {
                teamName = config.suggestions.first ?? ""
            }) {
                Text(config.suggestions.first ?? "")
                    .font(ApplicationTypography.UIFont_ChipLabel)
                    .foregroundStyle(ApplicationColors.chipAddTextColor)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
            }
            .background(
                Capsule()
                    .fill(ApplicationColors.chipAddSurfaceColor)
            )
            
            Button(action: {
                teamName = config.suggestions.last ?? ""
            }) {
                Text(config.suggestions.last ?? "")
                    .font(ApplicationTypography.UIFont_ChipLabel)
                    .foregroundStyle(ApplicationColors.chipAddTextColor)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
            }
            .background(
                Capsule()
                    .fill(ApplicationColors.chipAddSurfaceColor)
            )
        }
        .padding(.horizontal)
    }

}
#Preview {
    struct PreviewWrapper: View {
        @State private var selectedMode = 0
        @State private var team1Name: String = ""
        @FocusState private var isFocused: Bool
        
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                VStack(spacing: 14) {
                    InputCard_TeamName(config: .init(title: "Отбор 1",
                                                     surfaceColor: ApplicationColors.firstTeamSurfaceColor, suggestions: ["Тарикатите", "Лудите"]),
                                       teamName: $team1Name,
                    isFocused: $isFocused)
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
