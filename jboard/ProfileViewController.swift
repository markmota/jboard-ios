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
    let userCard = UserCard()
    let resumeCard = ResumeCard(isEditable: false)
    lazy var pagesCollection : PageCollectionView = {
        let pages = PageCollectionView()
        pages.buttons = [
            PageBarButtonItem(image: #imageLiteral(resourceName: "edit-profile"), page: 0),
            PageBarButtonItem(image: #imageLiteral(resourceName: "profile"), page: 1),
            PageBarButtonItem(image: #imageLiteral(resourceName: "profile-search"), page: 2)
        ]
        pages.cards = [self.userCard, self.resumeCard, EmptyView()]
        return pages
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.borderWidth = 4.0
        imageView.layer.borderColor = Theme.Colors.background.color.cgColor

        imageView.backgroundColor = Theme.Colors.background.color
        imageView.image = #imageLiteral(resourceName: "profile-image-white")

        return imageView
    }()
    
    lazy var topProfileView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.Colors.foreground.color
        view.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.height.equalTo(96)
        }
        self.profileImageView.layoutIfNeeded()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2.0
        self.profileImageView.clipsToBounds = true

        return view
    }()

    let completeProfileView: EmptyView = {
        let view = EmptyView()
        view.title = "Agrega tu curriculum aquí"
        view.button.addTarget(self, action: #selector(tapEditResume), for: .touchUpInside)
        return view
    }()

    var currentUser: User? {
        didSet {
            self.userCard.user = currentUser!
            self.userCard.user.image { img in
                self.profileImageView.image = img
            }
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
        self.view.addSubview(topProfileView)
        topProfileView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(self.view.snp.height).dividedBy(4)
        }
        
        self.view.addSubview(pagesCollection)
        pagesCollection.snp.makeConstraints { make in
            make.top.equalTo(self.topProfileView.snp.bottom)
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
        pagesCollection.scrollTo(page: 1)
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
