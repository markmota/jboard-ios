//
//  ProfileViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/5/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userCard: UserCard!
    @IBOutlet weak var resumeCard: ResumeCard!
    
    let completeProfileView : UIView = {
        let button = UIButton(type: .system)
        button.setTitle("Agrega tu curriculum aquí", for: .normal)
        button.tintColor = Theme.Colors.background.color
        
        let view = UIView()
        view.addSubview(button)
        button.snp.makeConstraints{ make in
            make.centerY.equalTo(view.snp.centerY).offset(-40)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width)
        }
        return view
    }()
    
    var currentUser : User? {
        didSet{
            self.userCard.user = currentUser!
        }
    }
    var resume : Resume? {
        didSet{
            self.resumeCard.resume = resume!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
        resumeCard.isHidden = true
        self.view.addSubview(completeProfileView)
        completeProfileView.snp.makeConstraints { make in
            make.top.equalTo(self.userCard.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadResume()
    }
    
    func loadResume() {
        Resume.current { resume in
            self.resume = resume
            self.completeProfileView.isHidden = true
            self.resumeCard.isHidden = false
            if self.currentUser == nil {
                self.currentUser = resume.user
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
