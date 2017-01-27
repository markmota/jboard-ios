//
//  ResumeCard.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/5/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation
import SnapKit

class ResumeCard : ScrollKerboardView {
    var editMode : Bool = false
    var resume = Resume() {
        didSet{
            yearsLabel.text = "\(resume.years_of_experience()) años de experiencia"
            startWorkingAtField.text = "tienes \(resume.years_of_experience()) años de experiencia"
            datePicker.date = resume.start_working_at
            bioText.text = resume.bio
            skillsList.reset()
            for skill in resume.skill_list {
                skillsList.addTag(skill)
                skillsText.text = "\(skillsText.text!)\(skill), "
            }
        }
    }
    
    let startWorkingAtField : UITextField = {
        let text = UITextField()
        text.placeholder = "¿Cuando empezaste a trabajar?"
        return text
    }()
    
    let datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.maximumDate = Date()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(didDatePickerChanged), for: .valueChanged)
        return picker
    }()
    
    let yearsLabel : UILabel = {
        let label = UILabel()
        label.text = ""
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
        textView.font = Theme.Fonts.text.font
        return textView
    }()
    
    let skillsText : UITextView = {
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
    
    init(isEditable editable: Bool) {
        super.init(frame: CGRect.zero)
        self.editMode = editable
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews() {
        self.startWorkingAtField.delegate = self
        self.bioText.delegate = self
        self.skillsText.delegate = self
        self.backgroundColor = Theme.Colors.foreground.color
        var firstElementBottom = startWorkingAtField.snp.bottom
        
        if editMode {
            addSubview(startWorkingAtField)
            startWorkingAtField.snp.makeConstraints { make in
                make.top.equalTo(self.snp.top).offset(15)
                make.left.equalTo(self.snp.leftMargin).offset(10)
                make.right.equalTo(self.snp.rightMargin).offset(-10)
                make.width.equalTo(self.snp.width).offset(-30)
            }

        } else {
            bioText.backgroundColor = self.backgroundColor
            skillsList.backgroundColor = self.backgroundColor
            addSubview(yearsLabel)
            yearsLabel.snp.makeConstraints { make in
                make.top.equalTo(self.snp.top).offset(15)
                make.left.equalTo(self.snp.leftMargin).offset(10)
                make.right.equalTo(self.snp.rightMargin).offset(-10)
                make.width.equalTo(self.snp.width).offset(-30)
            }
            firstElementBottom = yearsLabel.snp.bottom
        }
        
        addSubview(bioLabel)
        addSubview(bioText)
        addSubview(skillsLabel)
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(firstElementBottom).offset(10)
            make.left.equalTo(self.snp.leftMargin).offset(10)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
        }
        bioText.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.leftMargin).offset(5)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
            make.height.equalTo(64)
        }
        skillsLabel.snp.makeConstraints { make in
            make.top.equalTo(bioText.snp.bottom).offset(15)
            make.left.equalTo(self.snp.leftMargin).offset(10)
            make.right.equalTo(self.snp.rightMargin).offset(-10)
        }
        if editMode {
            addSubview(skillsText)
            skillsText.snp.makeConstraints { make in
                make.top.equalTo(skillsLabel.snp.bottom).offset(5)
                make.left.equalTo(self.snp.leftMargin).offset(5)
                make.right.equalTo(self.snp.rightMargin).offset(-10)
                make.height.equalTo(64)
            }
            addSubview(datePicker)
        } else {
            addSubview(skillsList)
            skillsList.snp.makeConstraints { make in
                make.top.equalTo(skillsLabel.snp.bottom).offset(5)
                make.left.equalTo(self.snp.leftMargin).offset(5)
                make.right.equalTo(self.snp.rightMargin).offset(-10)
                make.height.equalTo(128)
            }
        }
    }
    
    func hideDatePicker(out bounds : CGRect) {
         datePicker.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 150)
    }
    
    func animateDatePicker(toShow: Bool) {
        var frame = self.datePicker.frame
        UIView.animate(withDuration: 0.3) {
            if toShow {
                frame.origin.y = self.bounds.height - self.datePicker.frame.height
            } else {
                frame.origin.y = self.bounds.height
            }
            self.datePicker.frame = frame
        }
    }
    
    func didDatePickerChanged(_ sender: AnyObject) {
//        let format = DateFormatter()
//        format.dateFormat = "yyyy-MM-dd"
//        let dateString = format.string(from: self.datePicker.date)
        self.resume.start_working_at = self.datePicker.date
        self.startWorkingAtField.text = "tienes \(resume.years_of_experience()) años de experiencia"
    }
}

extension ResumeCard : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.isEqual(self.startWorkingAtField) {
            bioText.resignFirstResponder()
            skillsText.resignFirstResponder()
            animateDatePicker(toShow: true)
            return false
        } else {
            animateDatePicker(toShow: false)
            return true
        }
    }
}

extension ResumeCard : UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        animateDatePicker(toShow: false)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.isEqual(self.bioText) {
            self.resume.bio = self.bioText.text
        }
        if textView.isEqual(self.skillsText) {
            self.resume.setSkillListFrom(text: self.skillsText.text)
        }
    }
}
