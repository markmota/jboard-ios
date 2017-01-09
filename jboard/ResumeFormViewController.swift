//
//  ResumeFormViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/6/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ResumeFormViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    let resumeCard = ResumeCard(isEditable: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(resumeCard)
        resumeCard.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
        resumeCard.hideDatePicker(out: view.bounds)
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapSave(_ sender: Any) {
        print(resumeCard.resume.isValid())
        resumeCard.resume.create(onSuccess: { () in
            self.dismiss(animated: true, completion: nil)
        }, onFail: { error in
            let alertController = self.errorAlert(model: self.resumeCard.resume, error: error)
            self.present(alertController, animated: true, completion: nil)
        })
        
    }
}

extension ResumeFormViewController : UIModelAlert {}
