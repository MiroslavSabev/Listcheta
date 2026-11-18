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
    private static let mutedOnDarkColor = Color(red: 0xB7 / 255, green: 0xB3 / 255, blue: 0xD6 / 255)
    private static let ruleDescriptionColor = Color(red: 0x5D / 255, green: 0x59 / 255, blue: 0x80 / 255) // #5D5980
    private static let hostColor = Color(red: 0x7B / 255, green: 0x61 / 255, blue: 0xFF / 255)       // #7B61FF
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
    
    static let progressDotOnColor  = sunColor
    static let progressDotOffColor = inkColor.opacity(0.15)
    static let avatarTextColor     = Color(.white)

    // Team sheet (листче с играчите)
    static let sheetSurfaceColor   = paperColor
    static let sheetLineColor      = inkColor.opacity(0.12)
    static let sheetShadowColor    = inkColor.opacity(0.16)
    static let sheetEmptyTextColor = inkColor.opacity(0.25)
    static let sheetRemoveColor    = mutedColor
    static let secondTeamTitleColor = Color(red: 194/255, green: 24/255, blue: 91/255)   // #C2185B — розово заглавие
    static let firstTeamTitleColor  = Color(red: 0/255, green: 135/255, blue: 122/255)   // #00877A — тюркоазено заглавие
    
    static let bowlSurfaceColor = Color(red: 0x3A / 255, green: 0x34 / 255, blue: 0x70 / 255) // .rdy .bowl .b
    static let bowlShadeColor = Color(.black).opacity(0.22)
    static let bowlSlipShadowColor = Color(.black).opacity(0.25)
    
    static let darkScreenBackgroundColor = inkColor
    static let roundNumberColor = sunColor
    static let textOnDarkPrimaryColor = Color(.white)
     static let textOnDarkSecondaryColor = mutedOnDarkColor
    
    static let mascotOutlineColor        = inkColor
    static let mascotBodySurfaceColor    = paperColor
    static let mascotCheekSurfaceColor   = Color(red: 1.0, green: 0.36, blue: 0.54).opacity(0.6)
    static let mascotEyeHighlightColor   = Color(.white)
    
    static let dividerOnDarkColor = Color(.white).opacity(0.14)
    static let handoffAccentColor = sunColor
    
    static let roundPillActiveSurfaceColor = sunColor
    static let roundPillActiveTextColor = inkColor
    static let roundPillInactiveBorderColor = Color(.white).opacity(0.25)
    static let roundPillInactiveTextColor = Color(.white).opacity(0.5)
    
    static let buttonSuccessSurfaceColor       = Color(red: 0.24, green: 0.86, blue: 0.59) // #3DDC97
    static let buttonSuccessTextColor          = Color(red: 0.05, green: 0.23, blue: 0.16) // #0D3B28
    static let buttonSuccessShadowSurfaceColor = Color(red: 0.14, green: 0.63, blue: 0.42) // #23A06A
    
    static let buttonHostSurfaceColor       = Color(red: 0.482, green: 0.380, blue: 1.0)   // #7B61FF
    static let buttonHostShadowSurfaceColor = Color(red: 0.365, green: 0.263, blue: 0.910) // #5D43E8
    static let statChipSurfaceColor          = Color.white.opacity(0.10)
    static let statChipHighlightSurfaceColor = Color(red: 0.24, green: 0.86, blue: 0.59).opacity(0.18)
    static let onColorTextColor        = Color(.white)
    static let onColorEyebrowTextColor = Color(.white).opacity(0.8)
    static let onColorAvatarSurfaceColor = Color(.white)
    static let onColorNoteSurfaceColor = Color(.white).opacity(0.18)
    static let buttonOnColorSurfaceColor = Color(.white)
    static let buttonOnColorShadowSurfaceColor = Color(.black).opacity(0.2)
    static let avatarShadowColor       = Color(.black).opacity(0.25)
    
    static let scoreCardTextColor     = Color(.white)
    static let scoreCardSubtitleColor = Color(.white).opacity(0.85)

    // Carry card (.carrycard) — пренесено време
    static let carryCardSurfaceColor     = paperColor
    static let carryCardIconSurfaceColor = sunColor
    static let carryCardTextColor        = inkColor
    static let carryCardAccentTextColor  = Color(red: 194 / 255, green: 24 / 255, blue: 91 / 255)
    
    static let finaleBackgroundTopColor    = Color(red: 0x2A / 255, green: 0x24 / 255, blue: 0x52 / 255) // #2A2452
    static let finaleBackgroundBottomColor = Color(red: 0x17 / 255, green: 0x13 / 255, blue: 0x31 / 255) // #171331
    static let finaleTitleColor            = Color(.white)
    static let finaleScoreValueColor       = sunColor
    static let finaleScoreSeparatorColor   = Color(.white).opacity(0.35)

    // Trophy slip
    static let trophySlipSurfaceColor = paperColor
    static let trophySlipTextColor    = inkColor
    static let trophySlipTapeColor    = sunColor.opacity(0.75)

    // Ghost button on dark background
    static let buttonGhostOnDarkTextColor   = Color(.white)
    static let buttonGhostOnDarkBorderColor = Color(.white).opacity(0.3)

    // Confetti
    static let confettiPinkColor  = secondTeamColor
    static let confettiTealColor  = firstTeamColor
    static let confettiSunColor   = sunColor
    static let confettiWhiteColor = Color(.white)
    
    // Rule card (design-system.html #cards → .rulecard.r1–r4)
    static let ruleCardSurfaceColor = paperColor
    static let ruleCardDescriptionColor = ruleDescriptionColor
    static let ruleBadgeFirstSurfaceColor = secondTeamColor   // розово (teamA)
    static let ruleBadgeSecondSurfaceColor = firstTeamColor   // тюркоаз (teamB)
    static let ruleBadgeThirdSurfaceColor = sunColor
    static let ruleBadgeFourthSurfaceColor = hostColor
    static let ruleBadgeLightTextColor = Color(.white)
    static let ruleBadgeDarkTextColor = inkColor
}
