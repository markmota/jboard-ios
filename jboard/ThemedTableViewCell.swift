//
//  ThemedTableViewCell.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

@IBDesignable
class ThemedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Theme.Colors.background.color
        tintColor = Theme.Colors.tint.color
        separatorInset = .zero
        layoutMargins = .zero
    }

}
