//
//  RegisterViewController.swift
//  jboard
//
//  Created by markmota on 11/19/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit
import Alamofire
import SAMKeychain

class RegisterViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBAction func btnRegister(_ sender: AnyObject) {
        let user = User()
        user.first_name = txtName?.text ?? ""
        user.last_name = txtLastName?.text ?? ""
        user.email = txtEmail?.text ?? ""
        user.phone = txtPhone?.text ?? ""

        user.facebook_token = FBSDKAccessToken.current().tokenString
        user.signUp(onSuccess: { (token) in
            SAMKeychain.setPassword(token, forService: Secret.apiService, account: Secret.account)
            self.performSegue(withIdentifier: "completeRegister", sender: self)
        }, onFail: { error in
            self.errorAlert(model: user, error: error)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension RegisterViewController : UIModelAlert {}
