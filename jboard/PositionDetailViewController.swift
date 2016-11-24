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
    
    weak var position : Position!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderPostion()
        Position.find(id: position.id) { (pos) in
            self.position = pos
            self.renderPostion()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func renderPostion() {
        lblTitle.text = position.title
        lblCompany.text = position.company_name
        txvDescription.text = position.description
        lblCompatibility.text = "\(position.match) %"
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
