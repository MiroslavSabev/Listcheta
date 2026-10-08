//
//  SelectGameTypeView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 11.09.26.
//

import SwiftUI

enum GameMode: String, CaseIterable {
    case SinglePhone,
         MultiplePhones
}

struct SelectGameTypeView: View {
    
    @State private var selectedGameMode: GameMode = .SinglePhone
    @State private var isPrimaryButtonTapped: Bool = false

    var body: some View {
        BaseScreenTеmplate(titleText: "Как ще \nиграете?",
                                        onButtonTap: {
            isPrimaryButtonTapped = true
        }) {
            gameModesCards
        }
        .navigationDestination(isPresented: $isPrimaryButtonTapped) {
            switch selectedGameMode {
            case .SinglePhone:
                EnterTeamsNamesView()
            case .MultiplePhones:
                EnterTeamsNamesView()
            }
        }
    }

    private var gameModesCards: some View {
        VStack(spacing: 14) {
            ActionCard_Mode(icon: "📱",
                            title: "Един телефон",
                            description: "Подавате си телефона един на друг. Не е нужен интернет за други устройства.",
                            isSelected: selectedGameMode == .SinglePhone,
                            onSelect: {
                selectedGameMode = .SinglePhone
            })
            ActionCard_Mode(icon: "🔗",
                            title: "Всеки на своя телефон",
                            description: "Създава се стая с код. Играчите се включват от собствените си телефони — може и по няколко от едно устройство.",
                            isSelected: selectedGameMode == .MultiplePhones,
                            onSelect: {
                selectedGameMode = .MultiplePhones
            })
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
    }
}

#Preview {
    SelectGameTypeView()
}
