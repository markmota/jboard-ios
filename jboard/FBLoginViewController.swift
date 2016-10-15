//
//  FBLoginViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 10/14/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FBLoginViewController: UIViewController {
    @IBOutlet weak var loginButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil) {
            print("logged with facebook");
        } else {
            print("Never logged......");
        }
        super.viewWillAppear(animated)
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
