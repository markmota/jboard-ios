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
        // TODO: Show specific error message in the fiels, and validate the fomrat of the fields
        if let name = txtName.text, let lastName = txtLastName.text, let email = txtEmail.text, let phone = txtPhone.text {
            let user = User()
            user.first_name = name
            user.last_name = lastName
            user.email = email
            user.phone = phone
            user.facebook_token = FBSDKAccessToken.current().tokenString
            register(user: user,
                     completion: {
                        self.performSegue(withIdentifier: "completeRegister", sender: self)
                        self.dismiss(animated: true, completion: nil)
            },
                     failure: {
                        print("Oups!!!")
            })
        }else{
            let strMessage = "Faltan datos"
            let alertContr = UIAlertController(title: "Mensaje", message: strMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alertContr.addAction(alertAction)
            self.present(alertContr, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func register(user: User, completion: ((Void) -> Void)?, failure: ((Void) -> Void)?) {
        let request = try! APIClient.Router.register(user: user).asURLRequest()
        Alamofire.request(request).responseJSON { response in
            debugPrint(response)
            if response.result.isSuccess, let data = response.result.value as? [String: AnyObject], let authToken = data["auth_token"] as? String{
                SAMKeychain.setPassword(authToken, forService: Secret.apiService, account: Secret.account)
                if let completionBlock = completion {
                    DispatchQueue.main.async { completionBlock() }
                }
            } else {
                if let failureBlock = failure {
                    DispatchQueue.main.async { failureBlock() }
                }
            }
            
        }
    }

}
