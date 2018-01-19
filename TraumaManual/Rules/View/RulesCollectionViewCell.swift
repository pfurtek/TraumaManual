//
//  RulesCollectionViewCell.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class RulesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setupCell(with rule: RulesItem) {
        titleLabel.text = rule.title
        descriptionView.text = rule.description
        titleLabel.superview?.addBorder(edges: .all, color: .lightGray, thickness: 1)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
