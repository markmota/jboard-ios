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
    
    let likeButton : UIBarButtonItem = {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "checkmark"), style: .done, target: self, action: nil)
        return button
    }()
    
    let shareButton : UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        return button
    }()
    
    let hideButton : UIBarButtonItem = {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "xmark"), style: .done, target: self, action: nil)
        return button
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
        let toolbar = UIToolbar()
        toolbar.backgroundColor = Theme.Colors.tint.color
        toolbar.tintColor = Theme.Colors.background.color
        addSubview(toolbar)
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(likeButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(shareButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        items.append(hideButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        
        toolbar.items = items
        toolbar.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
