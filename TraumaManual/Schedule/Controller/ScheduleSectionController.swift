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
        if let theItem = item {
            if index == 0 {
                return CGSize(width: collectionContext!.containerSize.width,
                              height: 40)
            }
            let event = theItem.events[index-1]
            return CGSize(width: collectionContext!.containerSize.width,
                          height: 45 + event.name.height(withConstrainedWidth: collectionContext!.containerSize.width-150, font: UIFont.systemFont(ofSize: 18, weight: .semibold)) + event.place.height(withConstrainedWidth: collectionContext!.containerSize.width-150, font: UIFont.systemFont(ofSize: 18)))
        }
        return CGSize(width: collectionContext!.containerSize.width,
                      height: 0)
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
            cell.setupCell(with: theItem.events[index-1], first: first, last: last)
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.item = object as? ScheduleDayWrapper
    }
    
    override func didSelectItem(at index: Int) {
        
    }
}
