//
//  RulesSectionController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import Foundation
import IGListKit

class RulesSectionController : ListSectionController {
    
    var item: RulesItem?
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        if let theItem = item {
            return CGSize(width: collectionContext!.containerSize.width,
                          height: 65 + theItem.description.height(withConstrainedWidth: collectionContext!.containerSize.width-40, font: UIFont.systemFont(ofSize: 16)))
        }
        return CGSize(width: collectionContext!.containerSize.width,
                      height: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: "RulesCollectionViewCell", bundle: nil, for: self, at: index) as! RulesCollectionViewCell
        
        
        
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.item = object as? RulesItem
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}
