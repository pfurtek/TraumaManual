//
//  ScheduleCollectionViewCell.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topLinkView: UIView!
    @IBOutlet weak var bottomLinkView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    func setupCell(with event: ScheduleEvent, first: Bool = false, last: Bool = false) {
        topLinkView.isHidden = first
        bottomLinkView.isHidden = last
        timeLabel.text = event.time
        titleLabel.text = event.name
        placeLabel.text = event.place
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
