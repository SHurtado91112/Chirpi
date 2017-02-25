//
//  TweetCell.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/22/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    var nameText : String!
    
    @IBOutlet weak var handleLabel: UILabel!
    var handleText : String!
    
    @IBOutlet weak var timeLabel: UILabel!
    var timeText : String!
    
    @IBOutlet weak var tweetLabel: UILabel!
    var tweetText : String!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!

    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    
    var tweet: Tweet!
        {
        didSet
        {
            nameLabel.text = tweet.userName!
            handleLabel.text = "@\(tweet.userHandle!)"
            
            tweetLabel.text = tweet.text!
            
            //timeLabel.text = tweet.timestamp as! String
            
            if(tweet.avatarLink != nil)
            {
                avatarImageView.setImageWith(URL(string: tweet.avatarLink!)!)
            }
            
            avatarImageView.layer.cornerRadius = 15
            
            let avatarColor = hexStringToUIColor(hex: tweet.profileColor!)
            
            avatarImageView.layer.borderColor = avatarColor.cgColor
            avatarImageView.layer.borderWidth = 4
            avatarImageView.clipsToBounds = true

            if(tweet.timestamp != nil)
            {
                timeLabel.text = getFormat(date: tweet.timestamp!)
            }
            
            
            if(tweet.retweetCount == 0)
            {
                retweetCountLabel.text = ""
            }
            else
            {
                let countVal = tweet.retweetCount
                
                if(countVal >= 1000)
                {
                    let countText = "\(countVal)"
                    
                    let index1 = countText.index(countText.startIndex, offsetBy: 1)

                    let firstParse = countText.substring(to: index1)
                    
                    //second value
                    let start = countText.index(countText.startIndex, offsetBy: 1)
                    let end = countText.index(countText.startIndex, offsetBy: 2)
                    let range = start..<end
                    
                    let secondParse = countText.substring(with: range)
                    
                    print()
                    
                    retweetCountLabel.text = "\(firstParse).\(secondParse)K"
                    
                }
                else
                {
                    retweetCountLabel.text = "\(countVal)"
                }
            }
            
            if(tweet.favCount == 0)
            {
                favoriteCountLabel.text = ""
            }
            else
            {
                let countVal = tweet.favCount
                
                if(countVal >= 1000)
                {
                    let countText = "\(countVal)"
                    
                    let index1 = countText.index(countText.startIndex, offsetBy: 1)
                    
                    let firstParse = countText.substring(to: index1)
                    
                    //second value
                    let start = countText.index(countText.startIndex, offsetBy: 1)
                    let end = countText.index(countText.startIndex, offsetBy: 2)
                    let range = start..<end
                    
                    let secondParse = countText.substring(with: range)
                    
                    print()
                    
                    favoriteCountLabel.text = "\(firstParse).\(secondParse)K"
                    
                }
                else
                {
                    favoriteCountLabel.text = "\(tweet.favCount)"
                }
            }
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    func getDifference(date: Date) -> Int {
        
        let difference = Int(Date().timeIntervalSince(date))
        return difference
    }
    
    func getFormat(date: Date) -> String
    {
        let seconds = self.getDifference(date: date)
        
        let hours = seconds/3600
        
        if(hours >= 24)
        {
            let newDateFormat = DateFormatter()
            newDateFormat.dateFormat = "MMM d, yyyy"
            
            return newDateFormat.string(from: date)
        }
        else
        {
            if(hours >= 1)
            {
                return "\(hours)h"
            }
            else
            {
                let mins = seconds/60
                
                if(mins >= 1)
                {
                    return "\(mins)m"
                }
                else
                {
                    return "\(seconds)s"
                }
            }
            
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor
    {
        if ((hex.characters.count) != 6)
        {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: hex).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
