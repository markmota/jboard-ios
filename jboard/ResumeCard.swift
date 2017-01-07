//
//  ResumeCard.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/5/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

@IBDesignable
class ResumeCard : ScrollKerboardView {
    @IBInspectable
    public var isEditable : Bool = false {
        didSet{
            self.bioText.allowsEditingTextAttributes = isEditable
        }
    }
    var resume = Resume() {
        didSet{
            yearsLabel.text = "\(resume.years_of_experience()) años de experiencia"
            bioText.text = resume.bio
            for skill in resume.skill_list {
                skillsList.addTag(skill)
            }
        }
    }
    
    let yearsLabel : UILabel = {
        let label = UILabel()
        label.text = "8 años de experiencia"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()

    let bioLabel : UILabel = {
        let label = UILabel()
        label.text = "Bio"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()

    let bioText : UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = Theme.Fonts.lightText.font
        return textView
    }()
    
    let skillsLabel : UILabel = {
        let label = UILabel()
        label.text = "Habilidades"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()
    
    let skillsList : TagListView = {
        let tagView = TagListView()
        return tagView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews() {
        addSubview(yearsLabel)
        yearsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.left.equalTo(self.snp.leftMargin).offset(10)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
            make.width.equalTo(self.snp.width).offset(-30)
        }
        addSubview(bioLabel)
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(yearsLabel.snp.bottom).offset(10)
            make.left.equalTo(self.snp.leftMargin).offset(10)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
        }
        addSubview(bioText)
        bioText.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.leftMargin).offset(5)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
            make.height.equalTo(64)
        }
        addSubview(skillsLabel)
        skillsLabel.snp.makeConstraints { make in
            make.top.equalTo(bioText.snp.bottom).offset(15)
            make.left.equalTo(self.snp.leftMargin).offset(10)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
        }
        addSubview(skillsList)
        skillsList.snp.makeConstraints { make in
            make.top.equalTo(skillsLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.leftMargin).offset(5)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
            make.height.equalTo(64)
        }
    }
    
}
