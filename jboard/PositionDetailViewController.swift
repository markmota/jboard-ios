//
//  PositionDetailViewController.swift
//  jboard
//
//  Created by David_Ch_L on 19/11/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit

class PositionDetailViewController: UIViewController {
    @IBOutlet weak var skillListView: TagListView!
    
    let positionCard = PositionCard()
    weak var position : Position!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Theme.Colors.background.color
        self.view.addSubview(positionCard)
        positionCard.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(75)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.bottom.equalTo(self.view.snp.bottom).offset(-65)
        }
        positionCard.position = position
        Position.find(id: position.id) { (pos) in
            self.title = pos.company?.name
            self.positionCard.position = pos
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
