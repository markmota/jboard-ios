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
    
    weak var position: Position!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = position.title
        lblCompany.text = position.company_name
        txvDescription.text = position.description
        
        Position.find(id: position.id) { (pos) in
            debugPrint(pos)
        }
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
