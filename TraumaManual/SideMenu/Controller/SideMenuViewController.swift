//
//  SideMenuViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/16/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.versionLabel.text = "(app version: \(Bundle.main.releaseVersionNumberPretty))"
        print(Bundle.main.buildVersionNumber)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeClicked(_ sender: Any) {
        dismiss(animated: true) {
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window
            let rootVC = ListTableViewController(nibName: "ListTableViewController", bundle: Bundle.main)
            rootVC.root = true
            rootVC.list = TraumaModel.shared.root.sorted(by: {$0.key < $1.key})
            rootVC.title = "IU Trauma Manual"
            let navigationController = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func bookmarkClicked(_ sender: Any) {
        dismiss(animated: true) {
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window
            let rootVC = ListTableViewController(nibName: "ListTableViewController", bundle: Bundle.main)
            rootVC.root = true
            rootVC.bookmarks = true
            rootVC.list = TraumaModel.shared.bookmarks.sorted(by: {$0.key < $1.key})
            rootVC.title = "Bookmarks"
            let navigationController = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func recentlyClicked(_ sender: Any) {
        dismiss(animated: true) {
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window
            let rootVC = ListTableViewController(nibName: "ListTableViewController", bundle: Bundle.main)
            rootVC.root = true
            rootVC.recently = true
            rootVC.list = TraumaModel.shared.recentlyViewed
            rootVC.title = "Recently Viewed"
            let navigationController = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func requestClicked(_ sender: Any) {
        
    }
    
    @IBAction func feedbackClicked(_ sender: Any) {
        
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
