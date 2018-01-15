//
//  ListTableViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/14/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var list: [String: Any] = [:]
    var keys: [String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.keys = [String](self.list.keys)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.keys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.keys[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = self.keys[indexPath.row]
        let object = list[key]
        switch object {
        case is MarkdownText:
            let markdownTVC = MarkdownTextViewController(nibName: "MarkdownTextViewController", bundle: Bundle.main)
            markdownTVC.mditem = object as! MarkdownText
            self.navigationController?.pushViewController(markdownTVC, animated: true)
        case is Schedule:
            let scheduleVC = ScheduleViewController(nibName: "ScheduleViewController", bundle: Bundle.main)
            scheduleVC.schedule = object as! Schedule
            self.navigationController?.pushViewController(scheduleVC, animated: true)
        case is Rules:
            let rulesVC = RulesViewController(nibName: "RulesViewController", bundle: Bundle.main)
            rulesVC.rules = object as! Rules
            self.navigationController?.pushViewController(rulesVC, animated: true)
        case is Faculty:
            let facultyVC = FacultyViewController(nibName: "FacultyViewController", bundle: Bundle.main)
            facultyVC.faculty = object as! Faculty
            self.navigationController?.pushViewController(facultyVC, animated: true)
        case is Algorithm:
            let algorithmVC = AlgorithmViewController()
            algorithmVC.algorithm = object as! Algorithm
            self.navigationController?.pushViewController(algorithmVC, animated: true)
        case is [String: Any]:
            let listTVC = ListTableViewController(nibName: "ListTableViewController", bundle: Bundle.main)
            listTVC.list = object as! [String: Any]
            self.navigationController?.pushViewController(listTVC, animated: true)
        default: break
        }
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
