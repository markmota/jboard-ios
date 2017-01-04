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
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txvDescription: UITextView!
    @IBOutlet weak var skillListView: TagListView!
    
    weak var position : Position!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skillListView.target = self
        skillListView.tapAction = #selector(PositionDetailViewController.tapTag(_:))
        skillListView.longPressAction = #selector(PositionDetailViewController.longPressTag(_:))
        renderPostion()
        Position.find(id: position.id) { (pos) in
            self.title = pos.company?.name
            self.position = pos
            self.renderPostion()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func renderPostion() {
        lblTitle.text = position.title
        txvDescription.text = position.description
        lblCompatibility.text = "\(position.match) %"
        for skill in position.skillList {
            skillListView.addTag(skill)
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
    
    func tapTag(_ sender : UIGestureRecognizer) {
        let label = (sender.view as! UILabel)
        print("tap from \(label.text!)")
    }
    
    func longPressTag(_ sender : UIGestureRecognizer){
        let label = (sender.view as! UILabel)
        print("long press from \(label.text!)")
    }
    

}
