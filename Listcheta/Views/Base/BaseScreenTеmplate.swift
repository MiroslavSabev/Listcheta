//
//  BaseScreenTеmplate.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.09.26.
//

import SwiftUI

struct BaseScreenTеmplate<Content: View>: View {
    let titleText: String
    let eyebrowText: String?
    let buttonTitle: String
    let onButtonTap: () -> Void
    let isButtonEnabled: Bool
    @ViewBuilder let content: Content

    init(
        titleText: String,
        eyebrowText: String? = nil,
        buttonTitle: String = "Продължи",
        isButtonEnabled: Bool = true,
        onButtonTap: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.titleText = titleText
        self.eyebrowText = eyebrowText
        self.buttonTitle = buttonTitle
        self.isButtonEnabled = isButtonEnabled
        self.onButtonTap = onButtonTap
        self.content = content()
    }

    var body: some View {
        VStack {
            ScrollView {
                HeaderComponent(eyebrowText: eyebrowText ?? "",
                                titleText: titleText)
                content
            }
            Spacer()
            Button(action: onButtonTap) {
                Text(buttonTitle)
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(!isButtonEnabled)
            .padding()
        }
        .background(ApplicationColors.backgroundColor)
    }
}
