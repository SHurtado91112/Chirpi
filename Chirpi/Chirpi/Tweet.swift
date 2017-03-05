//
//  Tweet.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/19/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class Tweet: NSObject
{
    var id: String?
    
    var userName: String?
    var userHandle: String?
    
    var avatarLink: String?
    var profileColor: String?
    
    var text: String?
    var mediaURL: String?
    
    //retweeted USER
    var retweetUser: User?
    
    var retweetUserString: String?
    var retweetUserName: String?
    var retweetUserAvatarString: String?
    var retweetUserProfileColor: String?
    
    var retweetUserBannerString: String?
    
    var retweetUserTagline: String?
    
    var retweetUserFav: Int = 0
    
    var retweetUserFollower: Int = 0
    
    var retweetUserFollowing: Int = 0
    //end retweeted user
    
    
    var timestamp: Date?
    
    var isRetweeted: Bool?
    var isFavorited: Bool?
    
    var retweetCount: Int = 0
    var favCount: Int = 0
    
    var tagline: String?
    var userFav: Int = 0
    var userFollower: Int = 0
    var userFollowing: Int = 0
    var userBannerString: String?
    
    init(dictionary: NSDictionary)
    {
        print(dictionary)
        
        id = dictionary["id_str"] as? String
        
        let user = dictionary["user"] as? NSDictionary
        
        let entities = dictionary["entities"] as? NSDictionary
        
        if(user != nil)
        {
            retweetUser = User(dictionary: user!)
            
            userName = user?["name"] as? String
            
            userHandle = user?["screen_name"] as? String
            
            avatarLink = user?["profile_image_url_https"] as? String
            
            profileColor = user?["profile_link_color"] as? String
            
            tagline = user?["description"] as? String
            
            userFav = (user?["favourites_count"] as? Int)!
            
            userFollower = (user?["followers_count"] as? Int)!
            
            userFollowing = (user?["friends_count"] as? Int)!
            
            userBannerString = user?["profile_banner_url"] as? String
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0

        print("ENT: \(entities)")
        
        if let retweetStatus = dictionary["retweeted_status"] as? NSDictionary
        {
            
            //if tweet is retweeted, make it so that append retweeted image and user retweeted from
            let retweetedUserDictionary = retweetStatus["user"] as? NSDictionary
            
            if(retweetedUserDictionary != nil)
            {
                retweetUser = User(dictionary: retweetedUserDictionary!)
            }
            
            text = retweetStatus["text"] as? String
            favCount = (retweetStatus["favorite_count"] as? Int) ?? 0
        }
        else
        {
            text = dictionary["text"] as? String
            favCount = (dictionary["favorite_count"] as? Int) ?? 0
        }
        
        //This section should be extended to include all forms of url as well, 
        //not just from media keyword
        let media = entities?["media"] as? NSArray
        if(media != nil)
        {
            let mediaInd = media?[0] as? NSDictionary
            if(mediaInd != nil)
            {
                let removeURL = mediaInd?["url"] as? String
                if(removeURL != nil)
                {
                    print("MED: \(media!)")
                    print("MEDIND: \(mediaInd!)")
                    print("MEDURL: \(removeURL!)")

                    mediaURL = mediaInd?["media_url_https"] as? String
                    
                    text = text?.replacingOccurrences(of: removeURL!, with: "", options: .literal, range: nil)
                }
            }
        }
        
        isRetweeted = dictionary["retweeted"] as? Bool
        isFavorited = dictionary["favorited"] as? Bool
        
        
        let timestampString = dictionary["created_at"] as? String
        
        let formatter = DateFormatter()
        
        //E, d MMM yyyy HH:mm:ss Z
        //Fri, 24 Feb 2017 20:16:27 +0000
        
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if(timestampString != nil)
        {
            timestamp = formatter.date(from: timestampString!)
            
        }
        else
        {
            timestamp = formatter.date(from: "")
        }
        
    }
    
    class func tweetsFromArray(dictionaries: [NSDictionary]) -> [Tweet]
    {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries
        {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}
