//
//  RetweetDetailCell.swift
//  Chirpi
//
//  Created by Steven Hurtado on 3/5/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class RetweetDetailCell: UITableViewCell
{
    @IBOutlet weak var rechirpCountLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
