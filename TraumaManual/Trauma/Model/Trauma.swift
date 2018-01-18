//
//  Trauma.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/17/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import Foundation

class Trauma {
    var trauma1Text: String
    var trauma2Text: String
    var trauma3Text: String
    var traumaRText: String
    
    init(t1: String, t2: String, t3: String, tR: String) {
        self.trauma1Text = t1
        self.trauma2Text = t2
        self.trauma3Text = t3
        self.traumaRText = tR
    }
}
