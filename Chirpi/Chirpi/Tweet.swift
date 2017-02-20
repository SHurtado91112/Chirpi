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
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favCount: Int = 0
    
    init(dictionary: NSDictionary)
    {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if(timestampString != nil)
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm::ss Z y"
            
            timestamp = formatter.date(from: timestampString!)
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
