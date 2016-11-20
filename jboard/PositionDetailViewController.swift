//
//  PositionDetailViewController.swift
//  jboard
//
//  Created by David_Ch_L on 19/11/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit

class PositionDetailViewController: UIViewController {

    @IBOutlet weak var lblCompatibility: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txvDescription: UITextView!
    //var txtCompany = ""
    //var txtTitle = ""
    //var txtDescription = ""
    var position: Position!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCompany.text = position.company?.name
        lblTitle.text = position.title
        txvDescription.text = position.description
        
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
