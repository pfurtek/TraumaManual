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
    
    func addNode(id: String, text: String, color: String, edges: [String]) {
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
    var text: String
    var id: String
    var next: [String] = [] //ids
    var algorithm: Algorithm
    
    init(text: String, color: String, id: String, algorithm: Algorithm) {
        self.text = text
        self.color = UIColor(hex: color)
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
                    if let node = algorithm.getNode(id: id) {
                        array[node.text] = id
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

//protocol AlgorithmNode {
//    var color: UIColor {get}
//    var text: String {get}
//}
//
//class QuestionAlgorithmNode: AlgorithmNode {
//    var color: UIColor = .blue
//    var text: String
//    var answers: [String: AlgorithmNode] = [:]
//
//    init(question: String) {
//        self.text = question
//    }
//
//    func addNext(answer: String, next: AlgorithmNode) {
//        answers[answer] = next
//    }
//
//    func getAnswers() -> [String] {
//        return [String](self.answers.keys)
//    }
//
//    func next(for answer: String) -> AlgorithmNode? {
//        return answers[answer]
//    }
//}
//
//class AnswerAlgorithmNode: AlgorithmNode {
//    var color: UIColor = .green
//    var text: String
//    var next: AlgorithmNode?
//
//    init(answer: String) {
//        self.text = answer
//    }
//}
//
//class InfoAlgorithmNode: AlgorithmNode {
//    var color: UIColor = .purple
//    var text: String
//    var next: AlgorithmNode?
//
//    init(info: String) {
//        self.text = info
//    }
//}

class AlgorithmNodeWrapper : ListDiffable {
    var text: String
    var color: UIColor
    var answers: [String: String]
    
    init(text: String, color: UIColor, answers: [String: String]) {
        self.text = text
        self.color = color
        self.answers = answers
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        var id = "\(text) "
        for ans in answers.keys {
            id += "\(ans) "
        }
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true //TODO
    }
}
