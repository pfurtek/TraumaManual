//
//  TraumaModel.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 12/26/17.
//  Copyright © 2017 Pawel Furtek. All rights reserved.
//

import Foundation

fileprivate let singleton = TraumaModel()
class TraumaModel {
    static var shared: TraumaModel {
        get {
            return singleton
        }
    }
    
    var root: [String: Any] = [:]
    // Any can be:
        // [String: Any]
        // Algorithm
        // Faculty
        // Rules
        // Schedule
        // MarkdownText
    
    var bookmarks: [String: Any] = [:]
    
    
    func createModel() {
        // TODO: populate root
    }
    
    func addBookmark(title: String, object: Any) {
        bookmarks[title] = object
    }
    
    func removeBookmark(title: String) {
        bookmarks.removeValue(forKey: title)
    }
}

