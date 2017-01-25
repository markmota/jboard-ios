//
//  PositionsTableViewController.swift
//  jboard
//
//  Created by David_Ch_L on 19/11/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit

class PositionsTableViewController: ThemedTableViewController {
    var currentUser : User? = nil {
        didSet {
            setupNavBar()
        }
    }
    
    var positions : [Position] = [] {
        didSet { self.tableView.reloadData() }
    }
    
    let filterControl : UISegmentedControl = {
        let control = UISegmentedControl(items: ["Todos", "Favoritos", "Ocultos"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(onChangeFilter), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vacantes"
        Position.all(filter: nil) { result in
            self.positions = result
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(currentUserLoaded),
                                               name: Notification.Name.currentUserLoaded,
                                               object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.positions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "positionCell")!
        let position = self.positions[indexPath.row]
        cell.textLabel?.text = position.title
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = position.company?.name
        cell.detailTextLabel?.textColor = Theme.Colors.foreground.color
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createResume" { return }
        let destiny = segue.destination as! PositionDetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        let position = self.positions[indexPath!.row] as Position
        destiny.position = position
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section != 0 || self.currentUser == nil) { return 0 }
        return 55
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section != 0 ){ return nil }
        let viewHeader = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.view.frame.width,
                                              height: self.view.frame.height))
        viewHeader.isUserInteractionEnabled = true
        viewHeader.backgroundColor = Theme.Colors.darkBackground.color
        guard let user = self.currentUser else { return nil }
        if user.hasCompletedProfile() {
            viewHeader.addSubview(filterControl)
            filterControl.snp.makeConstraints{ make in
                make.centerY.equalTo(viewHeader.snp.centerY)
                make.centerX.equalTo(viewHeader.snp.centerX)
                make.width.equalTo(viewHeader.snp.width).offset(-50)
            }
        } else {
            let button = RoundButton(type: .system)
            button.tintColor = Theme.Colors.background.color
            button.setTitle("Agrega tu curriculum aquí", for: .normal)
            button.addTarget(self, action: #selector(tapCompleteProfile), for: .touchUpInside)
            
            viewHeader.addSubview(button)
            button.snp.makeConstraints{ make in
                make.centerY.equalTo(viewHeader.snp.centerY)
                make.centerX.equalTo(viewHeader.snp.centerX)
                make.width.equalTo(viewHeader.snp.width).offset(-30)
            }
        }
        
        return viewHeader
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupNavBar() {
        if let user = currentUser, user.employer {
            let createEmployerButton = UIButton(type: .system)
            createEmployerButton.setImage(#imageLiteral(resourceName: "briefcase"), for: .normal)
            createEmployerButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: createEmployerButton)
        }
    }
    
    // MARK: - Button Actions
    
    func tapCompleteProfile(sender: UIButton!) {
        performSegue(withIdentifier: "createResume", sender: self)
    }
    
    func onChangeFilter() {
        Position.all(filter: self.selectedFilter()) { result in self.positions = result }
    }

    func selectedFilter() -> String? {
        switch filterControl.selectedSegmentIndex {
        case 1:
            return "liked"
        case 2:
            return "hidden"
        default:
            return nil
        }
    }

    // MARK: - Observers
    
    func currentUserLoaded(_ notification: Notification) {
        self.currentUser = notification.userInfo?["user"] as? User ?? User()
        self.tableView.reloadData()
    }
}

