//
//  FeedTableViewCell.swift
//  InstaClone
//
//  Created by DeviOS on 26/01/15.
//  Copyright (c) 2015 DeviOS. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
 
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nome: UILabel!
    
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var data: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
