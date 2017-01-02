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
        
        var color: UIColor {
            switch self {
            case .tint:
                return UIColor(red:0.67, green:0.63, blue:0.79, alpha:1.00)
            case .background:
                return UIColor(red:0.55, green:0.50, blue:0.72, alpha:1.00)
            case .darkBackground:
                return UIColor(red:0.39, green:0.33, blue:0.53, alpha:1.00)
            case .sectionHeader:
                return UIColor(red:0.78, green:0.75, blue:0.86, alpha:1.00)
            case .foreground:
                return UIColor(red:0.89, green:0.87, blue:0.93, alpha:1.00)
            }
        }
    }
    
    enum Fonts {
        case title
        case boldTitle
        case lightText
        
        var font: UIFont {
            switch self {
            case .title:
                return UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
            case .boldTitle:
                return UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
            case .lightText:
                return UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
            }
        }
    }
}
