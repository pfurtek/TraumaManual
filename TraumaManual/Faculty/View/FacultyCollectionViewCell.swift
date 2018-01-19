//
//  FacultyCollectionViewCell.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class FacultyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var abreviationLabel: UILabel!
    
    func setupCell(with faculty: FacultyMember) {
        nameLabel.text = faculty.name
        numberLabel.text = faculty.number
        descriptionLabel.text = faculty.description
        abreviationLabel.text = faculty.abreviation
        nameLabel.superview?.addBorder(edges: .all, color: .lightGray, thickness: 1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
