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
        let label = UILabel()
        label.text = "Completa tu perfil"
        label.font = Theme.Fonts.title.font
        
        let button = UIButton(type: .system)
        button.setTitle("Aqui", for: .normal)
        button.tintColor = Theme.Colors.background.color
        
        let stack = UIStackView(arrangedSubviews: [label, button])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        let view = UIView()
        view.addSubview(stack)
        stack.snp.makeConstraints{ make in
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
