//
//  RulesViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit
import IGListKit

class RulesViewController: UIViewController {
    
    var rules: Rules!

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var bookmarkItem: UIBarButtonItem!
    
    var numberedTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        adapter.performUpdates(animated: false, completion: nil)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        
        if TraumaModel.shared.isBookmark(title: self.numberedTitle) {
            self.bookmarkItem = UIBarButtonItem(title: "BM", style: .plain, target: self, action: #selector(bookmarkAction(_:)))
        } else {
            self.bookmarkItem = UIBarButtonItem(title: "bm", style: .plain, target: self, action: #selector(bookmarkAction(_:)))
        }
        self.navigationItem.rightBarButtonItem = self.bookmarkItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        TraumaModel.shared.addRecentlyViewed(title: self.numberedTitle, object: rules)
    }
    
    @objc func bookmarkAction(_: Any) {
        if let title = self.numberedTitle {
            if TraumaModel.shared.isBookmark(title: title) {
                TraumaModel.shared.removeBookmark(title: title)
                self.bookmarkItem = UIBarButtonItem(title: "bm", style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            } else {
                TraumaModel.shared.addBookmark(title: title, object: self.rules)
                self.bookmarkItem = UIBarButtonItem(title: "BM", style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            }
            self.navigationItem.rightBarButtonItem = self.bookmarkItem
        }
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

extension RulesViewController : ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return rules.rulesList
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is RulesItem:
            return RulesSectionController()
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
