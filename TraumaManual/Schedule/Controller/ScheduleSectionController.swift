//
//  ScheduleSectionController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import Foundation
import IGListKit

class ScheduleSectionController : ListSectionController {
    
    var item: ScheduleDayWrapper?
    
    override func numberOfItems() -> Int {
        return (item?.events.count ?? -1) + 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        if index == 0 {
            return CGSize(width: collectionContext!.containerSize.width,
                          height: (item == nil) ? 0 : 70)
        }
        return CGSize(width: collectionContext!.containerSize.width,
                      height: (item == nil) ? 0 : 120)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            let cell = collectionContext!.dequeueReusableCell(withNibName: "DayCollectionViewCell", bundle: nil, for: self, at: index) as! DayCollectionViewCell
            
            if let theItem = item {
                cell.setupCell(with: theItem.day)
            }
            
            return cell
        }
        let cell = collectionContext!.dequeueReusableCell(withNibName: "ScheduleCollectionViewCell", bundle: nil, for: self, at: index) as! ScheduleCollectionViewCell
        
        if let theItem = item {
            let first = (index == 1)
            let last = (index == (theItem.events.count))
            cell.setupCell(with: theItem.events[index], first: first, last: last)
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.item = object as? ScheduleDayWrapper
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}
