////
////  TweetWithImageCell.swift
////  Chirpi
////
////  Created by Steven Hurtado on 3/3/17.
////  Copyright © 2017 Steven Hurtado. All rights reserved.
////
//
//import UIKit
//
//class TweetWithImageCell: UITableViewCell {
//    
//    weak var parentView: UIViewController? = nil
//    
//    var tweet: Tweet!
//        {
//        didSet
//        {
//            nameLabel.text = tweet.userName!
//            handleLabel.text = "@\(tweet.userHandle!)"
//            
//            tweetLabel.text = tweet.text!
//            
//            if(tweet.retweetUser != nil)
//            {
//                self.retweetUserLabel.text = "@\(tweet.retweetUser!)"
//                
//                self.retweetUserImgView.isHidden = false
//                
//            }
//            else
//            {
//                self.retweetUserImgView.isHidden = true
//                self.retweetUserLabel.text = ""
//            }
//            
//            
//            if(tweet.mediaURL != nil)
//            {
//                tweetLabel.text = "\(tweetLabel.text!)"
//                if(self.tweetImageView != nil)
//                {
//                    self.tweetImageView.setImageWith(URL(string: tweet.mediaURL!)!)
//                    self.tweetImageView.contentMode = .scaleAspectFit
//                    self.tweetImageView.isHidden = false
//                    
//                }
//                
//                //                let tweetImageView = UIImageView()
//                //
//                //                let xPos = self.tweetLabel.frame.origin.x
//                //                let yPos = self.tweetLabel.frame.origin.y  + self.tweetLabel.frame.height
//                //
//                //                tweetImageView.frame = CGRect(x: xPos, y: yPos, width: self.tweetLabel.frame.width, height: self.tweetLabel.frame.width)
//                //                tweetImageView.setImageWith(URL(string: tweet.mediaURL!)!)
//                //                tweetImageView.contentMode = .scaleAspectFit
//                //
//                //                let constUpLabel = NSLayoutConstraint(item: tweetImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.tweetLabel, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 8)
//                //
//                //                let constReply = NSLayoutConstraint(item: tweetImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: self.replyBtn, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 8)
//                //
//                //                let constRetweetBtn = NSLayoutConstraint(item: tweetImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: self.retweetBtn, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 8)
//                //
//                //                let constRetweetLabel = NSLayoutConstraint(item: tweetImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: self.retweetCountLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 8)
//                //
//                //                let constFavBtn = NSLayoutConstraint(item: tweetImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: self.favoriteBtn, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 8)
//                //
//                //                let constFavLabel = NSLayoutConstraint(item: tweetImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: self.favoriteCountLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 8)
//                //
//                //
//                //                self.addSubview(tweetImageView)
//                //
//                //
//                //
//                //                self.addConstraints([constUpLabel, constReply, constRetweetBtn, constRetweetLabel, constFavBtn, constFavLabel]);
//            }
//            else
//            {
//                //TO BE REMOVED
//                
//                if(self.tweetImageView != nil && self.window != nil)
//                {
//                    //                    print("Removing from Super View: \(self.nameLabel.text!) <-> \(self.window)")
//                    
//                    //                    self.tweetImageView.removeFromSuperview()
//                    
//                    //                    self.tweetImageView.isHidden = true
//                }
//            }
//            
//            
//            if(tweet.avatarLink != nil)
//            {
//                avatarImageView.setImageWith(URL(string: tweet.avatarLink!)!)
//            }
//            
//            avatarImageView.layer.cornerRadius = 15
//            
//            let avatarColor = hexStringToUIColor(hex: tweet.profileColor!)
//            
//            avatarImageView.layer.borderColor = avatarColor.cgColor
//            avatarImageView.layer.borderWidth = 4
//            avatarImageView.clipsToBounds = true
//            
//            if(tweet.timestamp != nil)
//            {
//                timeLabel.text = getFormat(date: tweet.timestamp!)
//            }
//            
//            if(tweet.isRetweeted != nil)
//            {
//                if(tweet.isRetweeted!)
//                {
//                    retweetBtn.tintColor = UIColor.twitterBlue
//                    retweetCountLabel.textColor = UIColor.twitterBlue
//                }
//                else
//                {
//                    retweetBtn.tintColor = UIColor.myOnyxGray
//                    retweetCountLabel.textColor = UIColor.myOnyxGray
//                }
//            }
//            
//            if(tweet.isFavorited != nil)
//            {
//                if(tweet.isFavorited!)
//                {
//                    favoriteBtn.tintColor = UIColor.myRoseMadder
//                    favoriteCountLabel.textColor = UIColor.myRoseMadder
//                }
//                else
//                {
//                    favoriteBtn.tintColor = UIColor.myOnyxGray
//                    favoriteCountLabel.textColor = UIColor.myOnyxGray
//                }
//            }
//            
//            if(tweet.retweetCount == 0)
//            {
//                retweetCountLabel.text = ""
//            }
//            else
//            {
//                let countVal = tweet.retweetCount
//                
//                retweetCountLabel.text = getFormatString(countVal: countVal)
//                
//                //                if(countVal >= 1000)
//                //                {
//                //                    let countText = "\(countVal)"
//                //
//                //                    let index1 = countText.index(countText.startIndex, offsetBy: 1)
//                //
//                //                    let firstParse = countText.substring(to: index1)
//                //
//                //                    //second value
//                //                    let start = countText.index(countText.startIndex, offsetBy: 1)
//                //                    let end = countText.index(countText.startIndex, offsetBy: 2)
//                //                    let range = start..<end
//                //
//                //                    let secondParse = countText.substring(with: range)
//                //
//                //                    print()
//                //
//                //                    retweetCountLabel.text = "\(firstParse).\(secondParse)K"
//                //
//                //                }
//                //                else
//                //                {
//                //                    retweetCountLabel.text = "\(countVal)"
//                //                }
//            }
//            
//            if(tweet.favCount == 0)
//            {
//                favoriteCountLabel.text = ""
//            }
//            else
//            {
//                let countVal = tweet.favCount
//                favoriteCountLabel.text = getFormatString(countVal: countVal)
//            }
//        }
//    }
//    
//    override func awakeFromNib()
//    {
//        super.awakeFromNib()
//        self.retweetUserImgView.isHidden = true
//        
//        self.retweetUserImgView.image = UIImage(named: "retweet-icon")?.withRenderingMode(.alwaysTemplate)
//        
//        self.retweetUserLabel.text = ""
//    }
//    
//    @IBAction func retweetPressed(_ sender: Any)
//    {
//        if(tweet.isRetweeted != nil)
//        {
//            animateMeBoi(button: self.retweetBtn)
//            
//            if(!tweet.isRetweeted!)
//            {
//                retweetBtn.tintColor = UIColor.twitterBlue
//                retweetCountLabel.textColor = UIColor.twitterBlue
//                
//                TwitterClient.sharedInstance?.retweetWithId(id: tweet.id!)
//                tweet.isRetweeted = !tweet.isRetweeted!
//                
//                let countVal = tweet.retweetCount + 1
//                retweetCountLabel.text = getFormatString(countVal: countVal)
//            }
//            else
//            {
//                retweetBtn.tintColor = UIColor.myOnyxGray
//                retweetCountLabel.textColor = UIColor.myOnyxGray
//                
//                TwitterClient.sharedInstance?.unretweetWithId(id: tweet.id!)
//                tweet.isRetweeted = !tweet.isRetweeted!
//                
//                let countVal = tweet.retweetCount - 1
//                retweetCountLabel.text = getFormatString(countVal: countVal)
//            }
//            
//            //            if(self.parent != nil)
//            //            {
//            //                self.parent?.reloadData()
//            //            }
//        }
//    }
//    
//    @IBAction func favoritePressed(_ sender: Any)
//    {
//        if(tweet.isFavorited != nil)
//        {
//            
//            animateMeBoi(button: self.favoriteBtn)
//            
//            if(!tweet.isFavorited!)
//            {
//                favoriteBtn.tintColor = UIColor.myRoseMadder
//                favoriteCountLabel.textColor = UIColor.myRoseMadder
//                
//                TwitterClient.sharedInstance?.favWithId(id: tweet.id!)
//                tweet.isFavorited = !tweet.isFavorited!
//                
//                tweet.favCount = tweet.favCount + 1
//                let countVal = tweet.favCount
//                favoriteCountLabel.text = getFormatString(countVal: countVal)
//            }
//            else
//            {
//                favoriteBtn.tintColor = UIColor.myOnyxGray
//                favoriteCountLabel.textColor = UIColor.myOnyxGray
//                
//                TwitterClient.sharedInstance?.unfavWithId(id: tweet.id!)
//                tweet.isFavorited = !tweet.isFavorited!
//                
//                tweet.favCount = tweet.favCount - 1
//                let countVal = tweet.favCount
//                favoriteCountLabel.text = getFormatString(countVal: countVal)
//            }
//            
//            //
//            //            if(self.parent != nil)
//            //            {
//            //                self.parent?.reloadData()
//            //            }
//        }
//    }
//    
//    func animateMeBoi(button: SpringButton)
//    {
//        button.animation = "morph"
//        button.curve = "easeOutQuart"
//        button.duration = 1.0
//        button.damping = 0.7
//        button.animate()
//    }
//    
//    func getDifference(date: Date) -> Int {
//        
//        let difference = Int(Date().timeIntervalSince(date))
//        return difference
//    }
//    
//    func getFormat(date: Date) -> String
//    {
//        let seconds = self.getDifference(date: date)
//        
//        let hours = seconds/3600
//        
//        if(hours >= 24)
//        {
//            let newDateFormat = DateFormatter()
//            newDateFormat.dateFormat = "MMM d, yyyy"
//            
//            return newDateFormat.string(from: date)
//        }
//        else
//        {
//            if(hours >= 1)
//            {
//                return "\(hours)h"
//            }
//            else
//            {
//                let mins = seconds/60
//                
//                if(mins >= 1)
//                {
//                    return "\(mins)m"
//                }
//                else
//                {
//                    return "\(seconds)s"
//                }
//            }
//            
//        }
//    }
//    
//    func hexStringToUIColor (hex:String) -> UIColor
//    {
//        if ((hex.characters.count) != 6)
//        {
//            return UIColor.gray
//        }
//        
//        var rgbValue:UInt32 = 0
//        Scanner(string: hex).scanHexInt32(&rgbValue)
//        
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
//    
//    func getFormatString(countVal: Int) -> String
//    {
//        switch(countVal)
//        {
//        case 1000...9999:
//            //in thousands
//            let countText = "\(countVal)"
//            
//            let index1 = countText.index(countText.startIndex, offsetBy: 1)
//            
//            let firstParse = countText.substring(to: index1)
//            
//            //second value
//            let start = countText.index(countText.startIndex, offsetBy: 1)
//            let end = countText.index(countText.startIndex, offsetBy: 2)
//            let range = start..<end
//            
//            let secondParse = countText.substring(with: range)
//            
//            print()
//            
//            return "\(firstParse).\(secondParse)K"
//        case 10000...99999:
//            //in ten thousands
//            
//            let countText = "\(countVal)"
//            
//            let index1 = countText.index(countText.startIndex, offsetBy: 1)
//            
//            let firstParse = countText.substring(to: index1)
//            
//            //second value
//            let start = countText.index(countText.startIndex, offsetBy: 1)
//            let end = countText.index(countText.startIndex, offsetBy: 2)
//            let range = start..<end
//            
//            let secondParse = countText.substring(with: range)
//            
//            //third value
//            let start2 = countText.index(countText.startIndex, offsetBy: 2)
//            let end2 = countText.index(countText.startIndex, offsetBy: 3)
//            let range2 = start2..<end2
//            
//            let thirdParse = countText.substring(with: range2)
//            print()
//            
//            return "\(firstParse)\(secondParse).\(thirdParse)K"
//            
//        case 100000...999999:
//            //in hundred thousands
//            
//            let countText = "\(countVal)"
//            
//            let index1 = countText.index(countText.startIndex, offsetBy: 1)
//            
//            let firstParse = countText.substring(to: index1)
//            
//            //second value
//            let start = countText.index(countText.startIndex, offsetBy: 1)
//            let end = countText.index(countText.startIndex, offsetBy: 2)
//            let range = start..<end
//            
//            let secondParse = countText.substring(with: range)
//            
//            //third value
//            let start2 = countText.index(countText.startIndex, offsetBy: 2)
//            let end2 = countText.index(countText.startIndex, offsetBy: 3)
//            let range2 = start2..<end2
//            
//            let thirdParse = countText.substring(with: range2)
//            print()
//            
//            return "\(firstParse)\(secondParse)\(thirdParse)K"
//        case 1000000...9999999:
//            //in millions
//            
//            let countText = "\(countVal)"
//            
//            let index1 = countText.index(countText.startIndex, offsetBy: 1)
//            
//            let firstParse = countText.substring(to: index1)
//            
//            //second value
//            let start = countText.index(countText.startIndex, offsetBy: 1)
//            let end = countText.index(countText.startIndex, offsetBy: 2)
//            let range = start..<end
//            
//            let secondParse = countText.substring(with: range)
//            
//            print()
//            
//            return "\(firstParse).\(secondParse)M"
//        default:
//            return "\(countVal)"
//        }
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool)
//    {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
//    
//}
//
//extension UILabel
//{
//    func addImageWithURL(urlString: String, afterLabel bolAfterLabel: Bool = true)
//    {
//        let attachment: NSTextAttachment = NSTextAttachment()
//        
//        let url = URL(string: urlString)
//        
//        if let data = try? Data(contentsOf: url!)
//        {
//            attachment.image = UIImage(data: data, scale: UIScreen.main.scale)
//            
//            attachment.image = attachment.image?.scaleImageToSize(newSize: CGSize(width: self.frame.width, height: self.frame.width))//(attachment.image?.size.height)!))
//            
//            let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
//            
//            if (bolAfterLabel)
//            {
//                let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
//                strLabelText.append(attachmentString)
//                
//                self.attributedText = strLabelText
//            }
//            else
//            {
//                let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
//                let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
//                mutableAttachmentString.append(strLabelText)
//                
//                self.attributedText = mutableAttachmentString
//            }
//            
//        }
//        
//    }
//    
//    
//    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false)
//    {
//        let attachment: NSTextAttachment = NSTextAttachment()
//        attachment.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
//        attachment.image = attachment.image?.scaleImageToSize(newSize: CGSize(width: (attachment.image?.size.width)!/2, height: ((attachment.image?.size.height)!/1.5)))
//        
//        
//        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
//        
//        if (bolAfterLabel)
//        {
//            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
//            strLabelText.append(attachmentString)
//            
//            self.attributedText = strLabelText
//        }
//        else
//        {
//            let strLabelText: NSAttributedString = NSAttributedString(string: self.text!)
//            let mutableAttachmentString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attachmentString)
//            mutableAttachmentString.append(strLabelText)
//            
//            self.attributedText = mutableAttachmentString
//        }
//    }
//    
//    func removeImage()
//    {
//        let text = self.text
//        self.attributedText = nil
//        self.text = text
//    }
//}
//
//extension UIImage
//{
//    /// Scales an image to fit within a bounds with a size governed by the passed size. Also keeps the aspect ratio.
//    /// Switch MIN to MAX for aspect fill instead of fit.
//    ///
//    /// - parameter newSize: newSize the size of the bounds the image must fit within.
//    ///
//    /// - returns: a new scaled image.
//    func scaleImageToSize(newSize: CGSize) -> UIImage {
//        var scaledImageRect = CGRect.zero
//        
//        let aspectWidth = newSize.width/self.size.width
//        let aspectheight = newSize.height/self.size.height
//        
//        let aspectRatio = max(aspectWidth, aspectheight)
//        
//        scaledImageRect.size.width = self.size.width * aspectRatio;
//        scaledImageRect.size.height = self.size.height * aspectRatio;
//        scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
//        scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;
//        
//        UIGraphicsBeginImageContext(newSize)
//        draw(in: scaledImageRect)
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return scaledImage!
//    }
//    
//}
