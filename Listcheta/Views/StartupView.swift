//
//  StartupView.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 31.08.26.
//

import SwiftUI

struct StartupView: View {
    
    @State private var isNewGameButtonPressed: Bool = false
    @State private var isNewGameWithCodeButtonPressed: Bool = false

    var body: some View {
        
        NavigationStack {
            VStack {
                headerImage
                titles
                buttons
            }
            .padding(.top, 50)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .top
            )
            .background(ApplicationColors.backgroundColor)
            .navigationDestination(isPresented: $isNewGameButtonPressed) {
                SelectGameTypeView()
            }
            .navigationDestination(isPresented: $isNewGameWithCodeButtonPressed) {
            }
        }
    }
    
    private var headerImage: some View {
        
        Image("image_startup")
            .resizable()
            .aspectRatio(1 / 0.70, contentMode: .fit)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 32)
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
                isNewGameWithCodeButtonPressed = true
            } label: {
                Text("Как се играе")

            }
            .buttonStyle(GhostButtonStyle())
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    StartupView()
}
