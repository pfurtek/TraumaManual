//
//  AlgorithmNodeSectionController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import Foundation
import IGListKit

class AlgorithmNodeSectionController : ListSectionController {
    
    var item: AlgorithmNodeWrapper?
    var keys: [String] = []
    
    override func numberOfItems() -> Int {
        return (item?.answers.keys.count ?? -1) + 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        if let theItem = item {
            if index == 0 {
                return CGSize(width: collectionContext!.containerSize.width,
                              height: 70 + theItem.text.height(withConstrainedWidth: collectionContext!.containerSize.width-60, font: UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.semibold)))
            }
            return CGSize(width: collectionContext!.containerSize.width,
                          height: 40)
        }
        return CGSize(width: collectionContext!.containerSize.width,
                      height: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            let cell = collectionContext!.dequeueReusableCell(withNibName: "AlgorithmNodeCollectionViewCell", bundle: nil, for: self, at: index) as! AlgorithmNodeCollectionViewCell
            
            if let theItem = item {
                cell.setupCell(with: theItem)
            }
            
            return cell
        }
        let cell = collectionContext!.dequeueReusableCell(withNibName: "AnswerCollectionViewCell", bundle: nil, for: self, at: index) as! AnswerCollectionViewCell
        
        cell.setupCell(with: self.keys[index+1])
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.item = object as? AlgorithmNodeWrapper
        if let theItem = self.item {
            self.keys = [String](theItem.answers.keys)
        }
    }
    
    override func didSelectItem(at index: Int) {
        if index != 0, let theItem = item {
            (self.viewController as? AlgorithmQuestionnaireViewController)?.changeCurrentNode(next: theItem.answers[self.keys[index+1]] ?? nil)
        }
    }
}
