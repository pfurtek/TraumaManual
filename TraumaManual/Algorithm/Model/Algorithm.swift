//
//  Algorithm.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 12/26/17.
//  Copyright © 2017 Pawel Furtek. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

class Algorithm {
    var root: AlgorithmNode? {
        get {
            for node in nodes.values {
                if in_count[node.id] == nil {
                    return node
                }
            }
            return nil
        }
    }
    var overview: String
    
    private var edges: [String: AlgorithmEdge] = [:]
    private var nodes: [String: AlgorithmNode] = [:]
    
    private var in_count: [String: Int] = [:]
    
    init(overview: String) {
        self.overview = overview
    }
    
    func addEdge(id: String, from: String, to: String) {
        self.edges[id] = AlgorithmEdge(id: id, from: from, to: to)
    }
    
    func addNode(id: String, text: String?, color: String?, edges: [String]) {
        let node = AlgorithmNode(text: text, color: color, id: id, algorithm: self)
        for edge in edges {
            if let to = self.edges[edge]?.to {
                node.addNext(id: to)
                if self.in_count[to] != nil {
                    self.in_count[to]! += 1
                } else {
                    self.in_count[to] = 1
                }
            }
        }
        self.nodes[id] = node
    }
    
    func getNode(id: String) -> AlgorithmNode? {
        return self.nodes[id]
    }
}

class AlgorithmNode {
    var color: UIColor
    var text: String?
    var id: String
    var next: [String] = [] //ids
    var algorithm: Algorithm
    
    init(text: String?, color: String?, id: String, algorithm: Algorithm) {
        self.text = text
        if let theColor = color {
            self.color = UIColor(hex: theColor)
        } else {
            self.color = .white
        }
        self.id = id
        self.algorithm = algorithm
    }
    
    func addNext(id: String) {
        next.append(id)
    }
    
    var answers: [String: String] {
        get {
            if next.count == 0 {
                return [:]
            } else if next.count == 1 {
                return ["Next": next.first!]
            } else {
                var array = [String: String]()
                for id in next {
                    if let node = algorithm.getNode(id: id), let theText = node.text {
                        array[theText.removeNewline()] = id
                    }
                }
                return array
            }
        }
    }
}

class AlgorithmEdge {
    var id: String
    var from: String
    var to: String
    
    init(id: String, from: String, to: String) {
        self.id = id
        self.from = from
        self.to = to
    }
}

class AlgorithmNodeWrapper : ListDiffable {
    var text: String?
    var color: UIColor
    var answers: [String: String]
    
    init(text: String?, color: UIColor, answers: [String: String]) {
        self.text = text?.removeNewline()
        self.color = color
        self.answers = answers
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        var id = "\(text ?? "") "
        for ans in answers.keys {
            id += "\(ans) "
        }
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true //TODO
    }
}
