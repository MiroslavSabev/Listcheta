//
//  ApplicationColors.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 31.08.26.
//

import SwiftUI

enum ApplicationColors {
    
    //Primiteives
    private static let inkColor = Color("InkColor")
    private static let sunColor = Color("SunColor")
    private static let applicationBackgroundColor = Color("ApplicationBackground")
    private static let mutedColor = Color("MutedColor")
    private static let sunShadowColor = Color("SunShadowColor")
    private static let inkShadowColor = Color("InkShadowColor")
    private static let paperColor = Color("PaperColor")
    private static let transparent = Color(.white).opacity(0)
    private static let firstTeamColor = Color("FirstTeamColor")
    private static let secondTeamColor = Color("SecondTeamColor")
    private static let chipOverlayColor = Color(.white).opacity(0.22)
    private static let chipSolidColor = Color(.white).opacity(0.95)
    
    //Tokens
    
    //ApplicationBackground
    
    static let backgroundColor = applicationBackgroundColor
    
    //Text
    
    static let textPrimaryColor = inkColor
    static let textSecondaryColor = mutedColor
    static let textTertiaryColor = paperColor
    
    //Buttons
    
    static let buttonAccentSurfaceColor = sunColor
    static let buttonAccentShadowSurfaceColor = sunShadowColor
    
    static let buttonPrimarySurfaceColor = inkColor
    static let buttonPrimaryShadowSurfaceColor = inkShadowColor
    
    static let buttonGhostSurfaceColor = transparent
    static let buttonGhostBorderColor = inkColor.opacity(0.25)
    
    static let firstTeamSurfaceColor = firstTeamColor
    static let secondTeamSurfaceColor = secondTeamColor
    


    // Chips
    static let chipDefaultSurfaceColor = chipOverlayColor
    static let chipAddSurfaceColor = chipSolidColor
    static let chipAddTextColor = inkColor

    // Team card edit pill
    static let teamCardEditBorderColor = Color(.white).opacity(0.5)
    static let teamCardEditTextColor = Color(.white).opacity(0.85)
}
