//
//  AlgorithmNodeCollectionViewCell.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/10/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit

class AlgorithmNodeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func setupCell(with node: AlgorithmNodeWrapper) {
        containerView.backgroundColor = node.color
        textLabel.text = node.text?.removeNewline()
        self.containerView.addBorder(edges: .all, color: .lightGray, thickness: 1)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
