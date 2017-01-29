//
//  EmployeerCard.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/26/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class EmployerCard: UIView {
    var employer = Employer() {
        didSet {
            self.companyField.text = employer.companyName
            self.positionField.text = employer.position
        }
    }

    let positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Posicion"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()

    let positionField: UITextField = {
        let text = UITextField()
        text.placeholder = "¿Cual es tu posicion en la Compañia?"
        text.addTarget(self, action: #selector(onChangePosition), for: .editingChanged)
        return text
    }()

    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre de Compañia"
        label.font = Theme.Fonts.boldTitle.font
        return label
    }()

    let companyField: UITextField = {
        let text = UITextField()
        text.placeholder = "¿Cual es nombre la Compañia?"
        text.addTarget(self, action: #selector(onChangeCompany), for: .editingChanged)
        return text
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
        addSubview(companyLabel)
        addSubview(companyField)
        addSubview(positionLabel)
        addSubview(positionField)

        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
        companyField.snp.makeConstraints { make in
            make.top.equalTo(self.companyLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
        positionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.companyField.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
        positionField.snp.makeConstraints { make in
            make.top.equalTo(self.positionLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(20)
        }
    }

    func onChangePosition() {
        self.employer.position = self.positionField.text ?? ""
    }

    func onChangeCompany() {
        self.employer.companyName = self.companyField.text ?? ""
    }

}
