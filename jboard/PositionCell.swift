//
//  PositionTableViewCell.swift
//  jboard
//
//  Created by David_Ch_L on 19/11/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit

class PositionCell : UIView {
    public var title : String? {
        didSet { self.titleLabel.text = title }
    }
    public var company : String? {
        didSet { self.companyLabel.text = company }
    }
    public var descriptionText : String? {
        didSet { self.descriptionLabel.text = descriptionText }
    }
    
    let titleLabel = UILabel()
    let companyLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup() {
        titleLabel.text = "title"
        self.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: frame.origin.x,
                                  y: frame.origin.y,
                                  width: frame.width,
                                  height: 20)

        companyLabel.text = "company"
        companyLabel.textAlignment = .right
        self.addSubview(companyLabel)
        companyLabel.frame = CGRect(x: frame.origin.x,
                                    y: frame.origin.y + 20,
                                    width: frame.width,
                                    height: 20)
        
        descriptionLabel.text = "description text"
        descriptionLabel.font = Theme.Fonts.lightText.font
        self.addSubview(descriptionLabel)
        companyLabel.frame = CGRect(x: frame.origin.x,
                                    y: frame.origin.y + 40,
                                    width: frame.width,
                                    height: 100)
    }
}
