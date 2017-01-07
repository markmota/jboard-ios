//
//  ResumeCard.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/5/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class ResumeCard : ScrollKerboardView {
    var editMode : Bool = false {
        didSet{
            self.bioText.allowsEditingTextAttributes = editMode
            self.skillsText.allowsEditingTextAttributes = editMode
            self.bioText.backgroundColor = editMode ? .blue : .red
        }
    }
    var resume = Resume() {
        didSet{
            yearsLabel.text = "\(resume.years_of_experience()) años de experiencia"
            bioText.text = resume.bio
            for skill in resume.skill_list {
                skillsList.addTag(skill)
                skillsText.text = "\(skillsText.text)\(skill), "
            }
        }
    }
    
    let startWorkingAtField : UITextField = {
        let text = UITextField()
        text.placeholder = "¿Cuando empezaste a trabajar?"
        return text
    }()
    
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
    
    let skillsText : UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = Theme.Fonts.lightText.font
        textView.backgroundColor = .red
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
    
    init(isEditable editable: Bool) {
        super.init(frame: CGRect.zero)
        self.editMode = editable
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(startWorkingAtField)
        startWorkingAtField.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.left.equalTo(self.snp.leftMargin).offset(10)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
            make.width.equalTo(self.snp.width).offset(-30)
        }
//            addSubview(yearsLabel)
//            yearsLabel.snp.makeConstraints { make in
//                make.top.equalTo(self.snp.top).offset(15)
//                make.left.equalTo(self.snp.leftMargin).offset(10)
//                make.right.equalTo(self.snp.rightMargin).offset(-10)
//                make.width.equalTo(self.snp.width).offset(-30)
//            }

        addSubview(bioLabel)
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(startWorkingAtField.snp.bottom).offset(10)
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
