//
//  ResumeFormViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/6/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ResumeFormViewController: UIViewController {
    @IBOutlet weak var resumeForm: ResumeCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapSave(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
