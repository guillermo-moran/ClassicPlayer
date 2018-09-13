//
//  ImageTableCell.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/12/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

class ImageTableCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel : UILabel!
    @IBOutlet weak var cellSubtitleLabel : UILabel!
    @IBOutlet weak var cellImageView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
