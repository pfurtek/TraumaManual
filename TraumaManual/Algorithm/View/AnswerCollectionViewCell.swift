//
//  AnswerCollectionViewCell.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/14/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var answerLabel: UILabel!
    
    func setupCell(with answer: String) {
        self.answerLabel.text = answer
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
