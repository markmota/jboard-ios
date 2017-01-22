//
//  ResumesTableViewController.swift
//  jboard
//
//  Created by Luis Ezcurdia on 1/20/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ResumesTableViewController: ThemedTableViewController {
    var resumes : [Resume] = [] {
        didSet { self.tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Candidatos"
        Resume.all { res in
            self.resumes = res
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resumes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resumeCell", for: indexPath)
        let resume = self.resumes[indexPath.row]
        cell.textLabel?.text = resume.user?.full_name
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = resume.bio
        cell.detailTextLabel?.textColor = Theme.Colors.foreground.color
        resume.user?.image { img in
            cell.imageView?.image = img
        }
        return cell
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

}