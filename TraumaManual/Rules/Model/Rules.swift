//
//  Rules.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import Foundation
import IGListKit

class Rules {
    var rulesList: [RulesItem] = []
    
    func addRule(title: String, description: String) {
        let rule = RulesItem(title: title, description: description)
        self.rulesList.append(rule)
    }
}

class RulesItem {
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

extension RulesItem : ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return "\(title) \(description)" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true //TODO
    }
    
    
}
