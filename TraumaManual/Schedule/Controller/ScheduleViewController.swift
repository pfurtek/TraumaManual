//
//  ScheduleViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit
import IGListKit

class ScheduleViewController: UIViewController {
    var schedule: Schedule!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        adapter.performUpdates(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ScheduleViewController : ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var objects: [ScheduleDayWrapper] = []
        for day in self.schedule.weekSchedule.keys {
            let wrapper = ScheduleDayWrapper(day: day, events: self.schedule.weekSchedule[day]!)
            objects.append(wrapper)
        }
        return objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is ScheduleDayWrapper:
            return ScheduleSectionController()
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
