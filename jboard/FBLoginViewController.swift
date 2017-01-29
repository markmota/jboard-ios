//
//  FBLoginViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 10/14/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SAMKeychain
import Alamofire

class FBLoginViewController: UIViewController {

    var activitIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var loginButton: FBSDKLoginButton!
    var loginSuccess: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton = FBSDKLoginButton()
        self.loginButton.readPermissions = ["public_profile", "email"]
        self.loginButton.frame = CGRect(x: 20,
                                        y: self.view.bounds.size.height - 80,
                                        width: self.view.bounds.size.width - 40,
                                        height: 30)
        self.loginButton.delegate = self
        self.view.addSubview(self.loginButton)

        self.activitIndicator.center = self.view.center
        self.activitIndicator.hidesWhenStopped = true
        self.activitIndicator.stopAnimating()
        self.view.addSubview(self.activitIndicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        if FBSDKAccessToken.current() != nil || loginSuccess {
            selectSegue()
        } else {
            super.viewDidAppear(animated)
        }
    }

    func selectSegue() {
        self.activitIndicator.startAnimating()
        loginAPI(FBSDKAccessToken.current().tokenString,
                 completion: {
                    self.activitIndicator.stopAnimating()
                    if let _ = Secret.apiToken.value {
                        self.performSegue(withIdentifier: "navigateToMain", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "showRegister", sender: self)

                    }
                 }, failure: {
                    self.activitIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "showRegister", sender: self)
                 })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func loginAPI(_ token: String, completion: ((Void) -> Void)?, failure: ((Void) -> Void)?) {
        let request = APIClient.Router.loginFacebook(token: token)
        Alamofire.request(request).responseJSON { response in
            if response.result.isSuccess, let data = response.result.value as? [String: AnyObject], let authToken = data["auth_token"] as? String {
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

extension FBLoginViewController : FBSDKLoginButtonDelegate {
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Facebook login ERROR: \(error)")
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            loginSuccess = true
        }
    }

    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        SAMKeychain.deletePassword(forService: Secret.apiService, account: Secret.account)
    }
}
