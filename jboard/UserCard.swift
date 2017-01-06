//
//  UserCard.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/4/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit

class UserCard: UIView {
    let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile-image-white")
        imageView.backgroundColor = Theme.Colors.background.color
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let firstNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Juan"
        label.font = Theme.Fonts.title.font
        return label
    }()
    
    let lastNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Perez Perez"
        label.font = Theme.Fonts.title.font
        return label
    }()
    
    let emailLabel : UILabel = {
        let label = UILabel()
        label.text = "email@example.com"
        label.font = Theme.Fonts.text.font
        return label
    }()
    
    let phoneLabel : UILabel = {
        let label = UILabel()
        label.text = "555-555-555"
        label.font = Theme.Fonts.lightText.font
        return label
    }()
    
    let editButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("editar", for: .normal)
        button.tintColor = Theme.Colors.background.color
        return button
    }()
    
    var user = User() {
        didSet {
            firstNameLabel.text = user.first_name
            lastNameLabel.text = user.last_name
            emailLabel.text = user.email
            phoneLabel.text = user.phone
            user.image { img in
                self.profileImage.image = img
            }
        }
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
        addSubview(profileImage)
        profileImage.snp.makeConstraints { make in
            make.width.equalTo(profileImage.snp.height)
            let insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            make.top.equalTo(self.snp.top).inset(insets)
            make.left.equalTo(self.snp.left).inset(insets)
            make.bottom.equalTo(self.snp.bottom).inset(insets)
        }
        self.layoutIfNeeded()
        profileImage.layer.cornerRadius = profileImage.layer.bounds.height / 25.0
        
        let labelStack = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel, emailLabel, phoneLabel])
        labelStack.axis = .vertical
        labelStack.distribution = .fillProportionally
        labelStack.alignment = .leading
        
        addSubview(labelStack)
        labelStack.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.topMargin).offset(15)
            make.right.equalTo(self.snp.rightMargin).offset(-5)
        }
    }

}
