//
//  BaseScreenTеmplate.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 18.09.26.
//

import SwiftUI

// Заявка за превъртане: към кое id и след колко изчакване.
// token прави всяка заявка различна, така че няколко поредни към едно и също id работят.
struct ScrollRequest: Equatable {
    let id: String
    var delay: Double = 0.35
    let token = UUID()
}

struct BaseScreenTеmplate<Content: View>: View {
    let titleText: String
    let eyebrowText: String?
    let buttonTitle: String
    let onButtonTap: () -> Void
    let isButtonEnabled: Bool
    let isButtonHidden: Bool
    @Binding var scrollRequest: ScrollRequest?
    @ViewBuilder let content: Content

    init(
        titleText: String,
        eyebrowText: String? = nil,
        buttonTitle: String = "Продължи",
        isButtonEnabled: Bool = true,
        isButtonHidden: Bool = false,
        scrollRequest: Binding<ScrollRequest?> = .constant(nil),
        onButtonTap: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.titleText = titleText
        self.eyebrowText = eyebrowText
        self.buttonTitle = buttonTitle
        self.isButtonEnabled = isButtonEnabled
        self.isButtonHidden = isButtonHidden
        self._scrollRequest = scrollRequest
        self.onButtonTap = onButtonTap
        self.content = content()
    }

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    HeaderComponent(eyebrowText: eyebrowText ?? "",
                                    titleText: titleText)
                    content
                }
                .scrollEdgeEffectStyle(.soft, for: .vertical)
                .onChange(of: scrollRequest) { _, request in
                    guard let request else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + request.delay) {
                        withAnimation(.easeOut(duration: 0.25)) {
                            proxy.scrollTo(request.id, anchor: .center)
                        }
                        scrollRequest = nil
                    }
                }
            }
            Spacer()
            if !isButtonHidden {
                Button(action: onButtonTap) {
                    Text(buttonTitle)
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(!isButtonEnabled)
                .padding()
            }
        }
        .background(ApplicationColors.backgroundColor)
    }
}
