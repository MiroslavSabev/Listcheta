//
//  StartupScreen.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 31.08.26.
//

import SwiftUI

struct StartupScreen: View {
    
    @State private var isNewGameButtonPressed: Bool = false
    @State private var isNewGameWithCodeButtonPressed: Bool = false
    @State private var isGameRulesButtonPressed: Bool = false

    var body: some View {
        
        NavigationStack {
            VStack {
                Illustration_Bowl()
                titles
                buttons
            }
            .padding(.top, 50)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center
            )
            .background(ApplicationColors.backgroundColor)
            .navigationDestination(isPresented: $isNewGameButtonPressed) {
                SelectGameTypeScreen()
            }
            .navigationDestination(isPresented: $isNewGameWithCodeButtonPressed) {
            }
            .navigationDestination(isPresented: $isGameRulesButtonPressed) {
            }
        }
    }
    
    private var titles: some View {
        
        VStack(alignment: .center, spacing: 8) {
    
            Text("Листчета")
                .font(ApplicationTypography.UIFont_Display)
                .foregroundStyle(Color(ApplicationColors.textPrimaryColor))
            
            Text("Играта за компании.\nОбяснявай, показвай, познавай.")
                .multilineTextAlignment(.center)
                .font(ApplicationTypography.UIFont_Body3)
                .foregroundStyle(Color(ApplicationColors.textSecondaryColor))
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
    }
    
    private var buttons: some View {
        
        VStack(spacing: 16) {
             
            Button {
                isNewGameButtonPressed = true
            } label: {
                Text("Нова игра")
            }
            .buttonStyle(AccentButtonStyle())
            
            Button {
                isNewGameWithCodeButtonPressed = true
            } label: {
                Text("Влез с код")
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button {
                isGameRulesButtonPressed = true
            } label: {
                Text("Как се играе")

            }
            .buttonStyle(GhostButtonStyle())
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    StartupScreen()
}
