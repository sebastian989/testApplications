//
//  CustomTableViewCell.swift
//  testgrability
//
//  Created by Sebastián Gómez on 13/04/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var applicationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}