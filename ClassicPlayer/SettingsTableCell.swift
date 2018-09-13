//
//  SettingsTableCell.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/12/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

class SettingsTableCell: UITableViewCell {
    
    @IBOutlet weak var  label: UILabel?
    @IBOutlet weak var toggle: UISwitch?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
