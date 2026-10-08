//
//  EnterTeamsNamesView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.09.26.
//


import SwiftUI


struct EnterTeamsNamesView: View {
    
    @State private var isPrimaryButtonTapped: Bool = false
    @State private var firstTeamName: String = ""
    @State private var secondTeamName: String = ""
    
    @FocusState private var isFirstFieldFocused: Bool
    @FocusState private var isSecondFieldFocused: Bool
    
    var body: some View {
        BaseScreenTеmplate(titleText: "Как се казват отборите",
                                               onButtonTap: {
            isPrimaryButtonTapped = true
        }) {
            InputCard_TeamName(config: .init(title: "Отбор 1",
                                             surfaceColor: ApplicationColors.firstTeamSurfaceColor,
                                             suggestions: ["Шматките", "Тарикатите"]),
                               teamName: $firstTeamName,
            isFocused: $isFirstFieldFocused)
            .padding()
            
            InputCard_TeamName(config: .init(title: "Отбор 2",
                                             surfaceColor: ApplicationColors.secondTeamSurfaceColor,
                                             suggestions: ["Миризливките", "Лудите"]),
                               teamName: $secondTeamName,
            isFocused: $isSecondFieldFocused)
            .padding()
        }
        .navigationDestination(isPresented: $isPrimaryButtonTapped) {
            AddPlayersNamesSreen()
        }
        .onDisappear {
            isFirstFieldFocused = false
            isSecondFieldFocused = false
            forceResignKeyboard()
        }
    }
}

#Preview {
    EnterTeamsNamesView()
}


extension View {
    func forceResignKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
