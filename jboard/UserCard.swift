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
 
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()
    
    let firstName: UILabel = {
        let label = UILabel()
        label.text = "Juan"
        label.font = Theme.Fonts.title.font
        return label
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apellidos"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()
    
    let lastName: UILabel = {
        let label = UILabel()
        label.text = "Perez Perez"
        label.font = Theme.Fonts.title.font
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Correo Electronico"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()

    let email: UILabel = {
        let label = UILabel()
        label.text = "email@example.com"
        label.font = Theme.Fonts.title.font
        return label
    }()

    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Telefono"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()

    let phone: UILabel = {
        let label = UILabel()
        label.text = "555-555-555"
        label.font = Theme.Fonts.title.font
        return label
    }()

    var user = User() {
        didSet {
            firstName.text = user.firstName
            lastName.text = user.lastName
            email.text = user.email
            phone.text = user.phone
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
        self.backgroundColor = Theme.Colors.foreground.color
        addSubview(firstNameLabel)
        firstNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).inset(-10)
        }
        addSubview(firstName)
        firstName.snp.makeConstraints { make in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        addSubview(lastNameLabel)
        lastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(firstName.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        addSubview(lastName)
        lastName.snp.makeConstraints { make in
            make.top.equalTo(lastNameLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(lastName.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        addSubview(email)
        email.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        addSubview(phone)
        phone.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-10)
        }
    }

}
