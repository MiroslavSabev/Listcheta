//
//  CircularTimer.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 14.11.26.
//

import SwiftUI

struct CircularTimerConfig {
    let totalTime: TimeInterval
    let remainingTime: TimeInterval
    let size: CGFloat = 120
    let lineWidth: CGFloat = 8
}

struct CircularTimer: View {
    let config: CircularTimerConfig
    
    private var progress: Double {
        guard config.totalTime > 0 else { return 0 }
        return 1 - (config.remainingTime / config.totalTime)
    }
    
    private var timeString: String {
        let minutes = Int(config.remainingTime) / 60
        let seconds = Int(config.remainingTime) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.12), lineWidth: config.lineWidth)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    ApplicationColors.buttonAccentSurfaceColor,
                    style: StrokeStyle(lineWidth: config.lineWidth, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: progress)
            
            Text(timeString)
                .font(ApplicationTypography.UIFont_Display)
                .foregroundStyle(Color.white)
        }
        .frame(width: config.size, height: config.size)
    }
}

#Preview {
    ZStack {
        ApplicationColors.darkScreenBackgroundColor.ignoresSafeArea()
        CircularTimer(config: .init(totalTime: 60, remainingTime: 42))
    }
    .environment(\.colorScheme, .light)
}