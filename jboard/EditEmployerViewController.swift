//
//  EditEmployeerViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/26/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit

class EditEmployerViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    let employerCard = EmployerCard()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(employerCard)
        employerCard.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }

    @IBAction func onTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTapSave(_ sender: Any) {
        employerCard.employer.user_data = true
        employerCard.employer.create(onSuccess: { () in
            self.dismiss(animated: true, completion: nil)
        }, onFail: { error in
            self.errorAlert(model: self.employerCard.employer, error: error)
        })
    }
}

extension EditEmployerViewController : UIModelAlert {}
