//
//  ListTableViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/14/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit
import SideMenu

class ListTableViewController: UITableViewController {
    
    var list: [(key: String, value: Any)] = []
    
    var root = false
    var bookmarks = false
    var recently = false
    
    var oldTitle: String?
    var oldList: [(key: String, value: Any)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "menuCell")
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        
        if root {
//            setupSideMenu()
            setupSearchBar()
        }
        
        self.oldList = self.list
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if bookmarks {
            self.list = TraumaModel.shared.bookmarks.sorted(by: { $0.key < $1.key})
            self.tableView.reloadData()
        } else if recently {
            self.list = TraumaModel.shared.recentlyViewed
            self.tableView.reloadData()
        }
    }
    
    func setupSearchBar() {
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction(_:)))
        self.navigationItem.rightBarButtonItems = [searchItem]
    }
    
    func setupSideMenu() {
        let sidemenuVC = SideMenuViewController(nibName: "SideMenuViewController", bundle: Bundle.main)
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: sidemenuVC)
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        
        let menuItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuAction(_:)))
        self.navigationItem.leftBarButtonItem = menuItem
    }
    
    @objc func menuAction(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @objc func searchAction(_: Any) {
        self.oldTitle = self.title
        self.title = ""
        self.oldList = self.list
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-70, height: 20))
        searchBar.barTintColor = UIColor(hex: "#7D110C")
        searchBar.tintColor = UIColor(hex: "#7D110C")
        let searchBarItem = UIBarButtonItem(customView: searchBar)
        let doneItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction(_:)))
        self.navigationItem.rightBarButtonItems = [doneItem, searchBarItem]
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    @objc func doneAction(_: Any) {
        setupSearchBar()
        self.title = self.oldTitle
        self.list = self.oldList
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! ListTableViewCell

        // Configure the cell...
        cell.titleLabel.text = self.list[indexPath.row].key.chopPrefix(4)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = self.list[indexPath.row].key
        let object = self.list[indexPath.row].value
        let choppedKey = key.chopPrefix(4)
        switch object {
        case is MarkdownText:
            let markdownTVC = MarkdownTextViewController(nibName: "MarkdownTextViewController", bundle: Bundle.main)
            markdownTVC.mditem = object as! MarkdownText
            markdownTVC.title = choppedKey
            markdownTVC.numberedTitle = key
            self.navigationController?.pushViewController(markdownTVC, animated: true)
        case is Schedule:
            let scheduleVC = ScheduleViewController(nibName: "ScheduleViewController", bundle: Bundle.main)
            scheduleVC.schedule = object as! Schedule
            scheduleVC.title = choppedKey
            scheduleVC.numberedTitle = key
            self.navigationController?.pushViewController(scheduleVC, animated: true)
        case is Rules:
            let rulesVC = RulesViewController(nibName: "RulesViewController", bundle: Bundle.main)
            rulesVC.rules = object as! Rules
            rulesVC.title = choppedKey
            rulesVC.numberedTitle = key
            self.navigationController?.pushViewController(rulesVC, animated: true)
        case is Faculty:
            let facultyVC = FacultyViewController(nibName: "FacultyViewController", bundle: Bundle.main)
            facultyVC.faculty = object as! Faculty
            facultyVC.title = choppedKey
            facultyVC.numberedTitle = key
            self.navigationController?.pushViewController(facultyVC, animated: true)
        case is Algorithm:
            let algorithmVC = AlgorithmViewController()
            algorithmVC.algorithm = object as! Algorithm
            algorithmVC.title = choppedKey
            algorithmVC.numberedTitle = key
            self.navigationController?.pushViewController(algorithmVC, animated: true)
        case is Trauma:
            let traumaVC = TraumaViewController()
            traumaVC.trauma = object as! Trauma
            traumaVC.title = choppedKey
            traumaVC.numberedTitle = key
            self.navigationController?.pushViewController(traumaVC, animated: true)
        case is [String: Any]:
            let listTVC = ListTableViewController(nibName: "ListTableViewController", bundle: Bundle.main)
            let map = object as! [String: Any]
            listTVC.list = map.sorted(by: {$0.key < $1.key})
            listTVC.title = choppedKey
            self.navigationController?.pushViewController(listTVC, animated: true)
        case is NullObject:
            let alert = UIAlertController(title: nil, message: "Not Yet Implemented!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20 + self.list[indexPath.row].key.chopPrefix(4).height(withConstrainedWidth: self.view.frame.width-32, font: UIFont.systemFont(ofSize: 18))
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

extension ListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.list = self.oldList
        } else {
            self.list = TraumaModel.shared.filterObjects(string: searchText)
        }
        self.tableView.reloadData()
    }
}
