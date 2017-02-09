//
//  ProfileViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/5/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit
import SCLAlertView

class ProfileViewController: UIViewController {
    @IBOutlet weak var userCard: UserCard!
    let resumeCard = ResumeCard(isEditable: false)
    lazy var pagesCollection : PageCollectionView = {
        let pages = PageCollectionView()
        pages.buttons = [
            PageBarButtonItem(image: #imageLiteral(resourceName: "edit-profile"), page: 0),
            PageBarButtonItem(image: #imageLiteral(resourceName: "profile"), page: 1),
            PageBarButtonItem(image: #imageLiteral(resourceName: "profile-search"), page: 2)
        ]
        pages.cards = [UserCard(), self.resumeCard, UIView()]
        return pages
    }()

    let completeProfileView: UIView = {
        let button = UIButton(type: .system)
        button.setTitle("Agrega tu curriculum aquí", for: .normal)
        button.tintColor = Theme.Colors.background.color
        button.addTarget(self, action: #selector(tapEditResume), for: .touchUpInside)

        let view = UIView()
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).offset(-40)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width)
        }
        return view
    }()

    var currentUser: User? {
        didSet {
            self.userCard.user = currentUser!
        }
    }
    var resume: Resume? {
        didSet {
            self.resumeCard.resume = resume!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Perfil"
        self.currentUser = (UIApplication.shared.delegate as! AppDelegate).currentUser
        self.view.addSubview(pagesCollection)
        pagesCollection.snp.makeConstraints { make in
            make.top.equalTo(self.userCard.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
//        if let user = self.currentUser, user.hasCompletedProfile() {
//            self.view.addSubview(resumeCard)
//            resumeCard.snp.makeConstraints { make in
//                make.top.equalTo(self.userCard.snp.bottom)
//                make.left.equalTo(self.view.snp.left)
//                make.right.equalTo(self.view.snp.right)
//                make.bottom.equalTo(self.view.snp.bottom)
//            }
//        } else {
//            self.view.addSubview(completeProfileView)
//            completeProfileView.snp.makeConstraints { make in
//                make.top.equalTo(self.userCard.snp.bottom)
//                make.left.equalTo(self.view.snp.left)
//                make.right.equalTo(self.view.snp.right)
//                make.bottom.equalTo(self.view.snp.bottom)
//            }
//        }
//        resumeCard.isHidden = true
        setupNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = self.currentUser, user.hasCompletedProfile() {
            loadResume()
        }

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

    func setupNavBar() {
        let editProfileButton = UIButton(type: .system)
        editProfileButton.setImage(#imageLiteral(resourceName: "edit-profile-white"), for: .normal)
        editProfileButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)

        let editResumeButton = UIButton(type: .system)
        editResumeButton.setImage(#imageLiteral(resourceName: "edit-resume-white"), for: .normal)
        editResumeButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        editResumeButton.addTarget(self, action: #selector(tapEditResume), for: .touchUpInside)

        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: editResumeButton),
            UIBarButtonItem(customView: editProfileButton)
        ]

        let createEmployerButton = UIButton(type: .system)
        createEmployerButton.setImage(#imageLiteral(resourceName: "profile-search-white"), for: .normal)
        createEmployerButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        createEmployerButton.addTarget(self, action: #selector(tapEditEmployeer), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: createEmployerButton)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "showResumeForm" { return }
        let destiny = segue.destination as! ResumeFormViewController
        guard let res = self.resume else { return }
        destiny.resume = res
    }

    func tapEditResume() {
        performSegue(withIdentifier: "showResumeForm", sender: self)
    }

    func tapEditEmployeer() {
        let alertView = SCLAlertView()
        alertView.addButton("Si") {
            self.performSegue(withIdentifier: "showEditEmployer", sender: self)
        }
        alertView.showInfo("Habiltar perfil", subTitle: "Deseas habilitar perfil de empleador?", closeButtonTitle: "No")
    }

}
