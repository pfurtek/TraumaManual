//
//  Faculty.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import Foundation
import IGListKit

class Faculty {
    var facultyList: [FacultyMember] = []
    
    func addMember(name: String, number: String, description: String, abreviation: String) {
        let member = FacultyMember(name: name, number: number, desc: description, abr: abreviation)
        facultyList.append(member)
    }
}

class FacultyMember {
    var name: String
    var number: String
    var description: String
    var abreviation: String
    
    init(name: String, number: String, desc: String, abr: String) {
        self.name = name.removeNewline()
        self.number = number.removeNewline()
        self.description = desc.removeNewline()
        self.abreviation = abr.removeNewline()
    }
}

extension FacultyMember : ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return "\(name) \(number) \(description) \(abreviation)" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true //TODO
    }
}
