//
//  AlgorithmQuestionnaireViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 12/26/17.
//  Copyright © 2017 Pawel Furtek. All rights reserved.
//

import UIKit
import IGListKit

class AlgorithmQuestionnaireViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var algorithm: Algorithm!
    var current: AlgorithmNode?
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.current = algorithm.root
        
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

extension AlgorithmQuestionnaireViewController : ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let cur = self.current else {return []}
        let wrapper = AlgorithmNodeWrapper(text: cur.text, color: cur.color, answers: cur.answers)
        return [wrapper]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is AlgorithmNodeWrapper:
            return AlgorithmNodeSectionController()
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    
}

extension AlgorithmQuestionnaireViewController {
    func changeCurrentNode(next: String) {
        self.current = self.algorithm.getNode(id: next)
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}
