//
//  DayCollectionViewCell.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/14/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    
    func setupCell(with day: String) {
        dayLabel.text = day
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
