//
//  ApplicationTypography.swift
//  Listcheta
//
//  Created by Miroslav Sabev on 31.08.26.
//

import SwiftUI

enum ApplicationTypography {
    
    // MARK: - Font names

    private enum FontName {
        
        static let CaveatBold = "Caveat-Bold"
        static let CaveatSemiBold = "Cavaet-SemiBold"
        
        static let ManropeBold = "Manrope-Bold"
        static let ManropeExtraBold = "Manrope-ExtraBold"
        static let ManropeSemiBold = "Manrope-SemiBold"
        static let ManropeMedium = "Manrope-Medium"
        static let ManropeRegular = "Manrope-Regular"
        
        static let UnboundedBlack = "Unbounded-Black"
        static let UnboundedMedium = "Unbounded-Medium"
        static let UnboundedBold = "Unbounded-Bold"
    }

    // MARK: - Display

    static let UIFont_Display = Font.custom(FontName.UnboundedBlack, size: 40)
    static let UIFont_Body3 = Font.custom(FontName.ManropeSemiBold, size: 18)
    static let UIFont_Body4 = Font.custom(FontName.ManropeExtraBold, size: 20)
    
    static let UIFont_Title = Font.custom(FontName.UnboundedBlack, size: 30)
    
    static let UIFont_CardTitle = Font.custom(FontName.UnboundedBold, size: 18)
    static let UIFont_CardDescription = Font.custom(FontName.ManropeSemiBold, size: 15)
    static let UIFont_Eyebrow = Font.custom(FontName.UnboundedBold, size: 16)
    
    static let UIFont_TeamCardTitle = Font.custom(FontName.UnboundedBold, size: 17)
    static let UIFont_ChipLabel = Font.custom(FontName.ManropeBold, size: 13)
    static let UIFont_EditPill = Font.custom(FontName.ManropeBold, size: 13)

    static let UIFont_WordRowNumber = Font.custom(FontName.UnboundedBold, size: 13)
    static let UIFont_WordRowInput  = Font.custom(FontName.CaveatBold, size: 24)
    
    static let UIFont_PlayerBarAvatar = Font.custom(FontName.ManropeExtraBold, size: 16)
    static let UIFont_PlayerBarName   = Font.custom(FontName.ManropeExtraBold, size: 16)
    static let UIFont_PlayerBarSub    = Font.custom(FontName.ManropeSemiBold, size: 12)

    static let UIFont_SheetTitle = Font.custom(FontName.UnboundedBold, size: 12)
    static let UIFont_SheetName  = Font.custom(FontName.CaveatBold, size: 24)
    static let UIFont_HintLine   = Font.custom(FontName.ManropeSemiBold, size: 13)
    
    static let UIFont_BowlSlip = Font.custom(FontName.CaveatBold, size: 16)
    static let UIFont_RoundNumber = Font.custom(FontName.UnboundedBlack, size: 15)
       static let UIFont_RoundName = Font.custom(FontName.UnboundedBlack, size: 32)
       static let UIFont_RoundDescription = Font.custom(FontName.ManropeSemiBold, size: 15)
       static let UIFont_RoundPill = Font.custom(FontName.UnboundedBold, size: 10)
       // А4 / 02б / 02в (.rdy) — по-компактни варианти на рунд интрото
       static let UIFont_RoundNumberCompact = Font.custom(FontName.UnboundedBlack, size: 13)
       static let UIFont_RoundNameCompact = Font.custom(FontName.UnboundedBlack, size: 25)
       static let UIFont_RoundDescriptionCompact = Font.custom(FontName.ManropeSemiBold, size: 13)
       static let UIFont_RoundPillCompact = Font.custom(FontName.UnboundedBold, size: 9.5)
    
    static let UIFont_HandoffLabel = Font.custom(FontName.ManropeBold, size: 12)
    static let UIFont_HandoffName = Font.custom(FontName.UnboundedBlack, size: 22)
    
    static let UIFont_VersusLabel = Font.custom(FontName.UnboundedBlack, size: 11)
    
    static let UIFont_SheetName2   = Font.custom(FontName.CaveatBold, size: 44)       // думата на листчето
    static let UIFont_Timer       = Font.custom(FontName.UnboundedBlack, size: 26)   // 0:42 в пръстена
    static let UIFont_MetaLabel   = Font.custom(FontName.ManropeBold, size: 11.5)
    static let UIFont_MetaValue   = Font.custom(FontName.UnboundedBlack, size: 14)
    static let UIFont_ButtonSmall = Font.custom(FontName.ManropeExtraBold, size: 14)
    
    static let UIFont_RoundTitle  = Font.custom(FontName.UnboundedBlack, size: 22)
    static let UIFont_StatLabel   = Font.custom(FontName.ManropeBold, size: 12.5)
    static let UIFont_StatValue   = Font.custom(FontName.UnboundedBlack, size: 13)
    static let UIFont_TileLabel   = Font.custom(FontName.ManropeExtraBold, size: 15)
    static let UIFont_TileIcon    = Font.system(size: 28, weight: .heavy)
    
    static let UIFont_HandoffAvatar   = Font.custom(FontName.UnboundedBlack, size: 34)
    static let UIFont_HandoffTeam     = Font.custom(FontName.ManropeBold, size: 13)
    static let UIFont_HandoffNote     = Font.custom(FontName.ManropeBold, size: 13)
    static let UIFont_HandoffNoteBold = Font.custom(FontName.ManropeExtraBold, size: 13)
    
    static let UIFont_ScoreCardTitle    = Font.custom(FontName.UnboundedBold, size: 14)
    static let UIFont_ScoreCardSubtitle = Font.custom(FontName.ManropeSemiBold, size: 11.5)
    static let UIFont_ScoreCardPoints   = Font.custom(FontName.UnboundedBlack, size: 28)

    static let UIFont_CarryCardText   = Font.custom(FontName.ManropeBold, size: 12.5)
    static let UIFont_CarryCardAccent = Font.custom(FontName.ManropeExtraBold, size: 12.5)
    static let UIFont_CarryCardIcon   = Font.system(size: 17)

    static let UIFont_WaitNote = Font.custom(FontName.ManropeBold, size: 13)
    static let UIFont_FinaleTitle          = Font.custom(FontName.UnboundedBlack, size: 24)
    static let UIFont_FinaleScore          = Font.custom(FontName.UnboundedBlack, size: 44)
    static let UIFont_FinaleScoreSeparator = Font.custom(FontName.UnboundedBlack, size: 26)
    static let UIFont_TrophyTeamName       = Font.custom(FontName.CaveatBold, size: 30)
    
    static let UIFont_RuleNumber      = Font.custom(FontName.UnboundedBlack, size: 13)
    static let UIFont_RuleTitle       = Font.custom(FontName.ManropeExtraBold, size: 14)
    static let UIFont_RuleDescription = Font.custom(FontName.ManropeSemiBold, size: 12.5)
}
