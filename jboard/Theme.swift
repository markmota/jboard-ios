//
//  Theme.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/5/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    enum Colors {
        case tint
        case background
        case darkBackground
        case sectionHeader
        case foreground
        case lightText
        
        var color: UIColor {
            switch self {
            case .tint:
                return UIColor(red:0.06, green:0.18, blue:0.32, alpha:1.00)
            case .background:
                return UIColor(red:0.96, green:0.33, blue:0.24, alpha:1.00)
            case .darkBackground:
                return UIColor(red:0.96, green:0.25, blue:0.19, alpha:1.00)
            case .sectionHeader:
                return UIColor(red:0.89, green:0.43, blue:0.18, alpha:1.00)
            case .foreground:
                return UIColor.white // UIColor(red:0.95, green:0.81, blue:0.33, alpha:1.00)
            case .lightText:
                return UIColor(red:0.98, green:0.92, blue:0.75, alpha:1.00)
            }
        }
    }
    
    enum Fonts {
        case titleFont
        case boldTitleFont
        
        var font: UIFont {
            switch self {
            case .boldTitleFont:
                return UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
            case .titleFont:
                return UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
            }
        }
    }
}
