//
//  ListTableViewCell.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/16/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
