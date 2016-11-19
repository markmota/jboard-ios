//
//  RoundButton.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/19/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.layer.bounds.height / 5
        self.tintColor = Theme.Colors.background.color
        self.backgroundColor = Theme.Colors.tint.color
    }
}
