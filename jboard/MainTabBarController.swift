//
//  MainTabBarController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = Theme.Colors.darkBackground.color
        self.tabBar.tintColor = UIColor.white
        self.tabBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
