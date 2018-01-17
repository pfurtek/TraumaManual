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
        // NullObject
    
    var bookmarks: [String: Any] = [:]
    var recentlyViewed: [(key: String, value: Any)] = []
    
    
    func createModel() {
        // TODO: populate root
        guard let manual = Factory.readPlistDictionary(filename: "manual") else {return}
        
        for key in manual.allKeys {
            if let item = manual[key] as? [String: Any], let theKey = key as? String {
                root[theKey] = recursiveCreateModel(dict: item)
            }
        }
    }
    
    func recursiveCreateModel(dict: [String: Any]) -> Any {
        guard let type = dict["type"] as? String else {return NullObject()}
        
        switch type {
        case "markdown":
            guard let filename = dict["filename"] as? String else {return NullObject()}
            let mdtext = Factory.readMD(filename: filename)
            return MarkdownText(text: mdtext)
        case "schedule":
            guard let filename = dict["filename"] as? String else {return NullObject()}
            let json: [String: Any] = Factory.readJSONDictionary(filename: filename)
            let schedule = Schedule()
            for day in json.keys {
                if let events = json[day] as? [[String: String]] {
                    for event in events {
                        if let title = event["title"], let place = event["location"], let time = event["time"] {
                            schedule.addEvent(day: day, name: title, time: time, place: place)
                        }
                    }
                }
            }
            return schedule
        case "list":
            var newDict: [String: Any] = [:]
            for key in dict.keys {
                if let item = dict[key] as? [String: Any] {
                    newDict[key] = recursiveCreateModel(dict: item)
                }
            }
            return newDict
        case "faculty":
            guard let filename = dict["filename"] as? String else {return NullObject()}
            let json: [[String: String]] = Factory.readJSONArray(filename: filename) as? [[String: String]] ?? []
            let faculty = Faculty()
            for member in json {
                if let name = member["name"], let title = member["title"], let rotation = member["rotation"], let pager = member["pager"] {
                    faculty.addMember(name: name, number: pager, description: title, abreviation: rotation)
                }
            }
            return faculty
        case "rules":
            guard let filename = dict["filename"] as? String else {return NullObject()}
            guard let plist = Factory.readPlistArray(filename: filename) else {return NullObject()}
            let rules = Rules()
            for role in plist {
                if let theRole = role as? [String: String], let position = theRole["position"], let description = theRole["description"] {
                    rules.addRule(title: position, description: description)
                }
            }
            return rules
        case "algorithm":
            guard let filename = dict["filename"] as? String, let overview = dict["image"] as? String else {return NullObject()}
            let json: [String: Any] = Factory.readJSONDictionary(filename: filename)
            guard let edges = json["edges"] as? [String: [String: String]], let nodes = json["nodes"] as? [String: Any] else {return NullObject()}
            let algorithm = Algorithm(overview: overview)
            for edgeID in edges.keys {
                guard let edge = edges[edgeID] else {continue}
                if let to = edge["target"], let from = edge["source"] {
                    algorithm.addEdge(id: edgeID, from: from, to: to)
                }
            }
            for nodeID in nodes.keys {
                guard let node = nodes[nodeID] as? [String: Any?] else {continue}
                if let text = node["value"] as? String, let color = node["fillColor"] as? String, let nodeEdges = node["edges"] as? [String: [String]], let outEdges = nodeEdges["out"] {
                    algorithm.addNode(id: nodeID, text: text, color: color, edges: outEdges)
                }
            }
            return algorithm
        default: break
        }
        return NullObject()
    }
    
    func addBookmark(title: String, object: Any) {
        bookmarks[title] = object
    }
    
    func removeBookmark(title: String) {
        bookmarks.removeValue(forKey: title)
    }
    
    func isBookmark(title: String) -> Bool {
        return bookmarks[title] != nil
    }
    
    func addRecentlyViewed(title: String, object: Any) {
        if let index = self.recentlyViewed.index(where: {$0.0 == title}) {
            self.recentlyViewed.remove(at: index)
        }
        self.recentlyViewed.insert((title, object), at: 0)
        if self.recentlyViewed.count > 20 {
            _ = self.recentlyViewed.dropLast()
        }
    }
}

class Factory {
    static func readPlistDictionary(filename: String) -> NSDictionary? {
        let fn = String(filename.split(separator: ".", maxSplits: 2, omittingEmptySubsequences: false).first ?? "")
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: fn, ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        return myDict
    }
    
    static func readPlistArray(filename: String) -> NSArray? {
        let fn = String(filename.split(separator: ".", maxSplits: 2, omittingEmptySubsequences: false).first ?? "")
        var myDict: NSArray?
        if let path = Bundle.main.path(forResource: fn, ofType: "plist") {
            myDict = NSArray(contentsOfFile: path)
        }
        return myDict
    }
    
    static func readMD(filename: String) -> String {
        let fn = String(filename.split(separator: ".", maxSplits: 2, omittingEmptySubsequences: false).first ?? "")
        guard let path = Bundle.main.path(forResource: fn, ofType: "md") else {
            return ""
        }
        do {
            let text = try String(contentsOfFile: path)
            return text
        } catch {/* error handling */}
        return ""
    }
    
    static func readJSONDictionary(filename: String) -> [String: Any] {
        let fn = String(filename.split(separator: ".", maxSplits: 2, omittingEmptySubsequences: false).first ?? "")
        guard let path = Bundle.main.path(forResource: fn, ofType: "json") else {return [:]}
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [String: Any] {
                return jsonResult
            }
        } catch {/* handle error */}
        return [:]
    }
    
    static func readJSONArray(filename: String) -> [[String: Any]] {
        let fn = String(filename.split(separator: ".", maxSplits: 2, omittingEmptySubsequences: false).first ?? "")
        guard let path = Bundle.main.path(forResource: fn, ofType: "json") else {return []}
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [[String: Any]] {
                return jsonResult
            }
        } catch {/* handle error */}
        return []
    }
}

class NullObject {
    
}

