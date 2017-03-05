//
//  UserProfileViewController.swift
//  Chirpi
//
//  Created by Steven Hurtado on 3/4/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var userDetailsView: UIView!

    @IBOutlet weak var userTagLineView: UIView!
    @IBOutlet weak var taglineLabel: UITextView!
    
    var avatarString: String?
    
    @IBOutlet weak var userBannerView: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var tweets : [Tweet] = []
    
    var user : String = ""
    var bannerString : String?
    var profileColor : String = ""
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var nameText: String?
    
    @IBOutlet weak var handleLabel: UILabel!
    var handleText: String?
    
    var tagText: String?
    
    @IBOutlet weak var followingCountLabel: UILabel!
    var followingCount : Int = 0
    
    @IBOutlet weak var followerCountLabel: UILabel!
    var followerCount : Int = 0
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    var favoriteCount : Int = 0
    
    let client = TwitterClient.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.scrollView?.delegate = self
        self.scrollView.contentSize = CGSize(width: scrollView.frame.size.width*2.0, height: scrollView.frame.size.height)

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        print(User.currentUser?.name! as String!)
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.myOnyxGray
        
        if(self.user == "")
        {
            self.user = (User._currentUser?.name!)!
            self.navBar.title = "Profile"
            
            self.tableView.isHidden = false
            
            self.nameLabel.text = self.user
            self.handleLabel.text = "@\((User._currentUser?.screenName!)!)"
            self.taglineLabel.text = User._currentUser?.tagline!
            
            self.avatarImageView.setImageWith((User._currentUser?.profileURL!)!)
            self.avatarImageView.layer.cornerRadius = 15
            self.avatarImageView.clipsToBounds = true
            
            self.followingCountLabel.text = self.getFormatString(countVal: (User._currentUser?.followingCount)!)
            
            self.followerCountLabel.text = self.getFormatString(countVal: (User._currentUser?.followerCount)!)
            
            self.favoriteCountLabel.text = self.getFormatString(countVal: (User._currentUser?.favCount)!)
            
        }
        else
        {
            self.navBar.title = "User"
            
            self.tableView.isHidden = true
            
            self.avatarImageView.setImageWith(URL(string: avatarString!)!)
            self.avatarImageView.layer.cornerRadius = 15
            self.avatarImageView.clipsToBounds = true
            
            self.nameLabel.text = self.nameText!
            self.user = self.nameText!
            
            self.handleLabel.text = self.handleText!
            self.taglineLabel.text = self.tagText!
            
            self.followingCountLabel.text = self.getFormatString(countVal: self.followingCount)
            
            self.followerCountLabel.text = self.getFormatString(countVal: self.followerCount)
            
            self.favoriteCountLabel.text = self.getFormatString(countVal: self.favoriteCount)
        }
        
        if(self.bannerString != nil)
        {
            self.userBannerView.setImageWith(URL(string: self.bannerString!)!)
        }
        else
        {
            self.userBannerView.setImageWith((User._currentUser?.profileBannerURL)!)
        }
        
        self.userBannerView.clipsToBounds = true

        //would work for other users if allowed the access
        client?.userTimeline(name: user, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        
        if(self.profileColor == "")
        {
            self.profileColor = (User._currentUser?.profileColor!)!
        }
        
        self.followingCountLabel.textColor = self.hexStringToUIColor(hex: self.profileColor)
        self.followerCountLabel.textColor = self.hexStringToUIColor(hex: self.profileColor)
        self.favoriteCountLabel.textColor = self.hexStringToUIColor(hex: self.profileColor)
        
        navigationController?.navigationBar.barTintColor = self.hexStringToUIColor(hex: self.profileColor)
        
        tabBarController?.tabBar.tintColor = self.hexStringToUIColor(hex: self.profileColor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(tweets.count)
        
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let tweet = self.tweets[indexPath.row]
        
        if(tweet.mediaURL != nil)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetImageCell", for: indexPath) as! TweetCell
            cell.hasImage = true
            cell.tweet = tweet
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
            
            cell.hasImage = false
            cell.tweet = tweet
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.selectionStyle = .none
        
        //        self.performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        self.pageControl.currentPage = Int(pageNumber)
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
