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
}
