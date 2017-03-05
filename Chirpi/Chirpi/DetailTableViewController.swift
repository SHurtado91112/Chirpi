//
//  DetailTableViewController.swift
//  Chirpi
//
//  Created by Steven Hurtado on 3/5/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController
{
    
    var detailUser: User?
    
    var hasImage = false
    
    var whoTweetedText: String?
    
    var creatorText: String?
    
    var creatorHandleText: String?
    
    var avatarString: String?
    
    var contentText: String?
    
    var contentImageString: String?
    
    var rechirpCount = 0
    var favCount = 0
    
    var dateStamp: Date?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120

        //tweetDetailSegue
       
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        switch(indexPath.row)
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetUser", for: indexPath) as! TweetUserCell
            
//            whoTweetedNameLabel: UILabel!
            
            print("DETAIL USER: \(self.detailUser)")
            
            cell.creatorNameLabel.text = self.detailUser?.name!
            cell.creatorHandleLabel.text = "@\((self.detailUser?.screenName!)!)"
            cell.avatarImageView.setImageWith((self.detailUser?.profileURL)!)
            
            let avatarColor = hexStringToUIColor(hex: (self.detailUser?.profileColor!)!)
            
            cell.avatarImageView.layer.borderColor = avatarColor.cgColor
            cell.avatarImageView.layer.borderWidth = 4
            cell.avatarImageView.layer.cornerRadius = 15
            
            cell.contentLabel.text = self.contentText!
            
            if(hasImage)
            {
                cell.contentImageView.setImageWith(URL(string: self.contentImageString!)!)
                
                cell.contentImageView.contentMode = .scaleAspectFill
                
                cell.contentImageView.layer.cornerRadius = 15
                
                cell.contentImageView.clipsToBounds = true
            }
            
            return cell;
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "retweetDetail", for: indexPath) as! RetweetDetailCell
            
            let rechirpNum = self.rechirpCount
            let favNum = self.favCount
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            
            cell.rechirpCountLabel.text = numberFormatter.string(from: NSNumber(value: rechirpNum))
            cell.favoriteCountLabel.text = numberFormatter.string(from: NSNumber(value: favNum))
            
            return cell;
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetButton", for: indexPath) as! ButtonCell
            
            cell.dateLabel.text = getFormat(date: self.dateStamp!)
            
            cell.rechirpLabel.text = getFormatString(countVal: self.rechirpCount)
            cell.favoriteLabel.text = getFormatString(countVal: self.favCount)
            
            return cell;
        default:
            let cell = UITableViewCell()
            return cell;
        }

        
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.selectionStyle = .none
    }
    
    func getDifference(date: Date) -> Int {
        
        let difference = Int(Date().timeIntervalSince(date))
        return difference
    }
    
    func getFormat(date: Date) -> String
    {
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "h:mm a MMMM d, yyyy"
        
        return newDateFormat.string(from: date)
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
    
    func getFormatString(countVal: Int) -> String
    {
        switch(countVal)
        {
        case 1000...9999:
            //in thousands
            let countText = "\(countVal)"
            
            let index1 = countText.index(countText.startIndex, offsetBy: 1)
            
            let firstParse = countText.substring(to: index1)
            
            //second value
            let start = countText.index(countText.startIndex, offsetBy: 1)
            let end = countText.index(countText.startIndex, offsetBy: 2)
            let range = start..<end
            
            let secondParse = countText.substring(with: range)
            
            print()
            
            return "\(firstParse).\(secondParse)K"
        case 10000...99999:
            //in ten thousands
            
            let countText = "\(countVal)"
            
            let index1 = countText.index(countText.startIndex, offsetBy: 1)
            
            let firstParse = countText.substring(to: index1)
            
            //second value
            let start = countText.index(countText.startIndex, offsetBy: 1)
            let end = countText.index(countText.startIndex, offsetBy: 2)
            let range = start..<end
            
            let secondParse = countText.substring(with: range)
            
            //third value
            let start2 = countText.index(countText.startIndex, offsetBy: 2)
            let end2 = countText.index(countText.startIndex, offsetBy: 3)
            let range2 = start2..<end2
            
            let thirdParse = countText.substring(with: range2)
            print()
            
            return "\(firstParse)\(secondParse).\(thirdParse)K"
            
        case 100000...999999:
            //in hundred thousands
            
            let countText = "\(countVal)"
            
            let index1 = countText.index(countText.startIndex, offsetBy: 1)
            
            let firstParse = countText.substring(to: index1)
            
            //second value
            let start = countText.index(countText.startIndex, offsetBy: 1)
            let end = countText.index(countText.startIndex, offsetBy: 2)
            let range = start..<end
            
            let secondParse = countText.substring(with: range)
            
            //third value
            let start2 = countText.index(countText.startIndex, offsetBy: 2)
            let end2 = countText.index(countText.startIndex, offsetBy: 3)
            let range2 = start2..<end2
            
            let thirdParse = countText.substring(with: range2)
            print()
            
            return "\(firstParse)\(secondParse)\(thirdParse)K"
        case 1000000...9999999:
            //in millions
            
            let countText = "\(countVal)"
            
            let index1 = countText.index(countText.startIndex, offsetBy: 1)
            
            let firstParse = countText.substring(to: index1)
            
            //second value
            let start = countText.index(countText.startIndex, offsetBy: 1)
            let end = countText.index(countText.startIndex, offsetBy: 2)
            let range = start..<end
            
            let secondParse = countText.substring(with: range)
            
            print()
            
            return "\(firstParse).\(secondParse)M"
        default:
            return "\(countVal)"
        }
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
