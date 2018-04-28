//
//  IncidentsTableViewCell.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/26/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit

class IncidentsTableViewCell: UITableViewCell {
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
