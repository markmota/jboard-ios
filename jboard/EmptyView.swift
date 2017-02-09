//
//  EmptyView.swift
//  jboard
//
//  Created by Luis Ezcurdia on 2/9/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = Theme.Fonts.text.font
        return label
    }()
    
    var title: String? {
        didSet{
            self.button.setTitle(title!, for: .normal)
        }
    }
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Action", for: .normal)
        button.tintColor = Theme.Colors.background.color
        return button
    }()
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews() {
        backgroundColor = Theme.Colors.foreground.color
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).offset(-40)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).dividedBy(2)
        }
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).dividedBy(3)
        }
    }
}
