//
//  HeaderComponent.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 13.09.26.
//

import SwiftUI

struct HeaderComponent: View {
    
    var eyebrowText: String = ""
    var titleText: String = ""
    
    var body : some View {
        
        VStack {
            VStack {
                Text(eyebrowText)
                    .font(ApplicationTypography.UIFont_Eyebrow)
                    .foregroundStyle(ApplicationColors.textSecondaryColor)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 4)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            
            
            VStack {
                Text(titleText)
                    .font(ApplicationTypography.UIFont_Title)
                    .foregroundStyle(ApplicationColors.textPrimaryColor)
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 24)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
        }
    }
    
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedMode = 0
        
        var body: some View {
            ZStack {
                ApplicationColors.backgroundColor.ignoresSafeArea()
                VStack(spacing: 14) {
                    HeaderComponent(eyebrowText: "НОВА ИГРА",
                                    titleText: "Как ще \nиграете?")
                }
                .padding(.horizontal, 24)
            }
        }
    }
    return PreviewWrapper()
}
