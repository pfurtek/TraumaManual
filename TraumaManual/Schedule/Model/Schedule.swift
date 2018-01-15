//
//  Schedule.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import Foundation
import IGListKit

class Schedule {
    var weekSchedule: [String: [ScheduleEvent]] = ["Monday":[], "Tuesday":[],
                                                   "Wednesday":[], "Thursday":[],
                                                   "Friday":[], "Saturday":[],
                                                   "Sunday":[]]
    
    func addEvent(day: String, name: String, time: String, place: String) {
        if weekSchedule[day] == nil {return}
        
        let event = ScheduleEvent(name: name, time: time, place: place)
        weekSchedule[day]!.append(event)
    }
}

class ScheduleEvent {
    var time: String
    var name: String
    var place: String
    
    init(name: String, time: String, place: String) {
        self.name = name
        self.time = time
        self.place = place
    }
}

class ScheduleDayWrapper : ListDiffable {
    var day: String
    var events: [ScheduleEvent]
    
    init(day: String, events: [ScheduleEvent]) {
        self.day = day
        self.events = events
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        var id = "\(day) "
        for event in events {
            id += "\(event.name) \(event.time) \(event.place) "
        }
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true //TODO
    }
}
