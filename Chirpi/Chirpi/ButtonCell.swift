//
//  ButtonCell.swift
//  Chirpi
//
//  Created by Steven Hurtado on 3/5/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell
{

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var rechirpButton: UIButton!
    
    @IBOutlet weak var rechirpLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    
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
