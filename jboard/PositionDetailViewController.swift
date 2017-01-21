//
//  PositionDetailViewController.swift
//  jboard
//
//  Created by David_Ch_L on 19/11/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit
import SCLAlertView

class PositionDetailViewController: UIViewController {
    @IBOutlet weak var skillListView: TagListView!
    
    let positionCard = PositionCard()
    var position = Position()
    var bookmark : Bookmark? {
        didSet {
            guard let status = bookmark?.status else { return }
            switch status {
            case "liked":
                self.positionCard.likeButton.isEnabled = false
            case "hidden":
                self.positionCard.hideButton.isEnabled = false
            case "match":
                self.positionCard.likeButton.isEnabled = false
                self.positionCard.hideButton.isEnabled = false
            default:
                self.positionCard.likeButton.isEnabled = true
                self.positionCard.hideButton.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Theme.Colors.background.color
        self.view.addSubview(positionCard)
        positionCard.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.bottom.equalTo(self.view.snp.bottom).offset(-20)
        }
        positionCard.likeButton.target = self
        positionCard.likeButton.action = #selector(tapOnLikeButton)
        
        positionCard.shareButton.target = self
        positionCard.shareButton.action = #selector(tapOnShareButton)
        
        positionCard.hideButton.target = self
        positionCard.hideButton.action = #selector(tapOnHideButton)
        
        positionCard.position = position
        Position.find(id: position.id) { (pos, bmrk) in
            self.title = pos.company?.name
            self.positionCard.position = pos
            self.position = pos
            self.bookmark = bmrk
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
    func tapOnLikeButton() {
        self.positionCard.likeButton.isEnabled = false
        position.bookmarkAsLiked(onSuccess: { (bookmark) in
            SCLAlertView().showSuccess("Bookmark", subTitle: "Agregado a favoritos")
            _ = self.navigationController?.popViewController(animated: true)
        }, onFail: { (error) in
            self.errorAlert(model: self.position, error: error)
            self.positionCard.likeButton.isEnabled = true
        })
    }
    
    func tapOnShareButton() {
        let msg = ["Encontre una vacante de \(position.title) en esta app"]
        let avc = UIActivityViewController(activityItems: msg, applicationActivities: nil)
        avc.setValue("Trabajo en Jboard", forKey: "Subject")
        self.present(avc, animated: true, completion: nil)
    }
    
    func tapOnHideButton(){
        self.positionCard.hideButton.isEnabled = false
        position.bookmarkAsHidden(onSuccess: { (bookmark) in
            SCLAlertView().showInfo("Bookmark", subTitle: "Agregado a ocultos")
            _ = self.navigationController?.popViewController(animated: true)
        }, onFail: { (error) in
            self.errorAlert(model: self.position, error: error)
            self.positionCard.hideButton.isEnabled = true
        })
    }

}

extension PositionDetailViewController : UIModelAlert {}

