//
//  RegisterViewController.swift
//  jboard
//
//  Created by markmota on 11/19/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBAction func btnRegister(_ sender: AnyObject) {
        
        // TODO: Show specific error message in the fiels, and validate the fomrat of the fields
        if txtName.text != "", txtLastName.text != "", txtEmail.text != "", txtPhone.text != ""{
            print ("seguimos")
            //var user:User =
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
    

}
