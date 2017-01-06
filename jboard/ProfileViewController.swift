//
//  ProfileViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/5/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userCard: UserCard!
    var currentUser : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        if currentUser == nil {
            User.current { (user) in
                self.currentUser = user
                self.userCard.user = user
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
