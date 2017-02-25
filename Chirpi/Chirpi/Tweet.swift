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
    var userName: String?
    var userHandle: String?
    
    var avatarLink: String?
    var profileColor: String?
    
    var text: String?
    var timestamp: Date?
    
    var retweetCount: Int = 0
    var favCount: Int = 0
    
    init(dictionary: NSDictionary)
    {
        print(dictionary)
        
        let user = dictionary["user"] as? NSDictionary
        
        if(user != nil)
        {
            userName = user?["name"] as? String
            
            userHandle = user?["screen_name"] as? String
            
            avatarLink = user?["profile_image_url_https"] as? String
            
            profileColor = user?["profile_link_color"] as? String
        }
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        if let retweetStatus = dictionary["retweeted_status"] as? NSDictionary
        {
            favCount = (retweetStatus["favorite_count"] as? Int) ?? 0
        }
        else
        {
            favCount = (dictionary["favorite_count"] as? Int) ?? 0
        }
        
        
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
