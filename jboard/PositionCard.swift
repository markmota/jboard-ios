//
//  PositionCard.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/14/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class PositionCard: UIView {
    var position = Position() {
        didSet {
            matchLabel.text = "\(position.match)%"
            titleLabel.text = position.title
            descriptionText.text = position.description
            skillsView.reset()
            for skill in position.skill_list {
                skillsView.addTag(skill)
            }
        }
    }
    
    let matchLabel : UILabel = {
        let label = UILabel()
        label.text = "0.0%"
        label.textAlignment = .right
        label.font = Theme.Fonts.lightText.font
        return label
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Position"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()
    
    let descriptionText : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = "lorem ipsum dolor quet sit amet"
        textView.font = Theme.Fonts.text.font
        textView.backgroundColor = Theme.Colors.foreground.color
        return textView
    }()
    
    let skillsLabel : UILabel = {
        let label = UILabel()
        label.text = "Habilidades"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()
    
    let skillsView : TagListView = {
        let view = TagListView()
        return view
    }()

    
    init() {
        super.init(frame: CGRect.zero)
        setupSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews() {
        backgroundColor = Theme.Colors.foreground.color
        addSubview(matchLabel)
        matchLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(15)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.matchLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
        addSubview(descriptionText)
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(self.snp.height).dividedBy(4)
        }
        addSubview(skillsLabel)
        skillsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionText.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
        addSubview(skillsView)
        skillsView.snp.makeConstraints { make in
            make.top.equalTo(self.skillsLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(3)
            make.right.equalTo(self.snp.right).offset(-3)
            make.height.equalTo(self.snp.height).dividedBy(3)
        }
    }
}
