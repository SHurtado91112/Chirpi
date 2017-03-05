//
//  TweetUserCell.swift
//  Chirpi
//
//  Created by Steven Hurtado on 3/5/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class TweetUserCell: UITableViewCell
{    
    @IBOutlet weak var creatorNameLabel: UILabel!
    
    @IBOutlet weak var creatorHandleLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    
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
