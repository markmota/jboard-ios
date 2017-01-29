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
            matchLabel.text = "\(position.match * 100)%"
            titleLabel.text = position.title
            descriptionText.text = position.description
            skillsView.reset()
            for skill in position.skillList {
                skillsView.addTag(skill)
            }
        }
    }

    let matchLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0%"
        label.textAlignment = .right
        label.font = Theme.Fonts.lightText.font
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Position"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()

    let descriptionText: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = "lorem ipsum dolor quet sit amet"
        textView.font = Theme.Fonts.text.font
        textView.backgroundColor = Theme.Colors.foreground.color
        return textView
    }()

    let skillsLabel: UILabel = {
        let label = UILabel()
        label.text = "Habilidades"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()

    let skillsView: TagListView = {
        let view = TagListView()
        return view
    }()

    let likeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "checkmark"), style: .done, target: nil, action: nil)
        return button
    }()

    let shareButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        return button
    }()

    let hideButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "xmark"), style: .done, target: nil, action: nil)
        return button
    }()

    convenience init() {
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
        addSubview(matchLabel)
        addSubview(titleLabel)
        addSubview(descriptionText)
        addSubview(skillsLabel)
        addSubview(skillsView)
        matchLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.matchLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(self.snp.height).dividedBy(4)
        }
        skillsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionText.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
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
