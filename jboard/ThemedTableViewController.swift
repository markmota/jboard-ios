//
//  DefaultTableViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ThemedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = Theme.Colors.darkBackground.color
        tableView.backgroundColor = Theme.Colors.background.color
        tableView.tableFooterView = UIView()
    }


}
