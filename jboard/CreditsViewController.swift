//
//  CreditsViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/17/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit
import Down

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Creditos"
        loadMarkdown()
    }

    func loadMarkdown() {
        let filepath = Bundle.main.path(forResource: "credits", ofType: "md")!
        let markdown = try! String(contentsOfFile: filepath)
        let downView = try! DownView(frame: self.view.bounds, markdownString: markdown)
        downView.isOpaque = false
        downView.backgroundColor = Theme.Colors.foreground.color
        self.view.addSubview(downView)
        downView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }

}
