//
//  TagLabel.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/27/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import Foundation
class TagLabel: UILabel {
    
    func setup(text : String, color : UIColor) {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.textColor = UIColor.white
        self.backgroundColor = color
        self.text = text
        self.font = UIFont.systemFont(ofSize: 18)
        self.sizeToFit()
        self.textAlignment = NSTextAlignment.center
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupGestureActions(forTarget: AnyObject?, tapAction : Selector?, longPressAction : Selector?) {
        guard let target = forTarget else { return }
        if tapAction != nil {
            let tap = UITapGestureRecognizer(target: target, action: tapAction)
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(tap)
        }
        if longPressAction != nil {
            let longPress = UILongPressGestureRecognizer(target: target, action: longPressAction)
            self.addGestureRecognizer(longPress)
        }
    }
}
