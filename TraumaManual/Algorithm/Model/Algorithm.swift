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
    var title: String
    var root: AlgorithmNode
    var overview: String
    
    init(title: String, root: AlgorithmNode, overview: String) {
        self.title = title
        self.root = root
        self.overview = overview
    }
}

protocol AlgorithmNode {
    var color: UIColor {get}
    var text: String {get}
}

class QuestionAlgorithmNode: AlgorithmNode {
    var color: UIColor = .blue
    var text: String
    var answers: [String: AlgorithmNode] = [:]
    
    init(question: String) {
        self.text = question
    }
    
    func addNext(answer: String, next: AlgorithmNode) {
        answers[answer] = next
    }
    
    func getAnswers() -> [String] {
        return [String](self.answers.keys)
    }
    
    func next(for answer: String) -> AlgorithmNode? {
        return answers[answer]
    }
}

class AnswerAlgorithmNode: AlgorithmNode {
    var color: UIColor = .green
    var text: String
    var next: AlgorithmNode?
    
    init(answer: String) {
        self.text = answer
    }
}

class InfoAlgorithmNode: AlgorithmNode {
    var color: UIColor = .purple
    var text: String
    var next: AlgorithmNode?
    
    init(info: String) {
        self.text = info
    }
}

class AlgorithmNodeWrapper : ListDiffable {
    var text: String
    var color: UIColor
    var answers: [String: AlgorithmNode?]
    
    init(text: String, color: UIColor, answers: [String: AlgorithmNode?]) {
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
