//
//  Font.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/23/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

typealias MainFont = Font.CourierNew

enum Font {
    enum CourierNew: String {//CourierNewPS-BoldMT
        /*
         *** Courier New ***
         CourierNewPS-BoldItalicMT
         CourierNewPS-BoldMT
         CourierNewPS-ItalicMT
         CourierNewPSMT
         
         let attrString = NSAttributedString(string: "Label Text", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
         label.attributedText = attrString
         */
        case normal = "MT"
        case italic = "-ItalicMT"
        case bold = "-BoldMT"
        case boldItalic = "-BoldItalicMT"
        func with(size: CGFloat) -> UIFont {
            guard let customFont = UIFont(name: "CourierNewPS\(rawValue)", size: size) else {
                fatalError("""
                    Failed to load the "CustomFont" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
            }
            return UIFontMetrics.default.scaledFont(for: customFont)
        }
        func defaultSize() -> UIFont {
            return self.with(size: 60)
        }
    }
    enum HelveticaNeue: String {
        case ultraLightItalic = "UltraLightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case ultraLight = "UltraLight"
        case italic = "Italic"
        case light = "Light"
        case thinItalic = "ThinItalic"
        case lightItalic = "LightItalic"
        case bold = "Bold"
        case thin = "Thin"
        case condensedBlack = "CondensedBlack"
        case condensedBold = "CondensedBold"
        case boldItalic = "BoldItalic"
        
        func with(size: CGFloat) -> UIFont {
            guard let customFont = UIFont(name: "HelveticaNeue-\(rawValue)", size: size) else {
                fatalError("""
                    Failed to load the "CustomFont-Light" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
            }
            return UIFontMetrics.default.scaledFont(for: customFont)
        }
        func `default`() -> UIFont {
            return self.with(size: UIFont.labelFontSize)
        }
    }
}
