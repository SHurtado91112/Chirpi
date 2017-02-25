//
//  Util.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/19/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import Foundation
import UIKit

struct KeysAndTokens
{
    static let baseURL : String = "https://api.twitter.com/"
    static let consumerKey : String = "CQMmBlL50J99VSXeYDstZVcII"
    static let consumerSecret : String = "vahBAi9HsQG961EGhHIqgrXUaiSMLXwTXizGuhqLMQQXOgeVxI"
    
    static let requestToken : String = "oauth/request_token"
    static let authorizeURL : String = "oauth/authorize?oauth_token="
    static let accessToken : String = "oauth/access_token"
    
    static let callbackURL : String = "chirpiDemo://oauthor"
    
    static let verify_credentials : String = "1.1/account/verify_credentials.json"
    static let home_timeline : String = "1.1/statuses/home_timeline.json"
    
    static let retweet_URL : String = "1.1/statuses/retweet/"
    static let unretweet_URL : String = "1.1/statuses/unretweet/"
    static let favorite_URL : String = "1.1/favorites/create.json?id="
    static let unfavorite_URL : String = "1.1/favorites/destroy.json?id="
}

extension UIColor
{
    static var myOffWhite: UIColor
    {
        //FAFAFA
        return UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
    }
    
    static var mySalmonRed: UIColor
    {
        //F55D3E
        return UIColor(red: 245.0/255.0, green: 93.0/255.0, blue: 62.0/255.0, alpha: 1)
    }
    
    static var myRoseMadder: UIColor
    {
        //D72638
        return UIColor(red: 215.0/255.0, green: 38.0/255.0, blue: 56.0/255.0, alpha: 1)
    }
    
    static var myOnyxGray: UIColor
    {
        //878E88
        return UIColor(red: 135.0/255.0, green: 142.0/255.0, blue: 136.0/255.0, alpha: 1)
    }
    
    static var myTimberWolf: UIColor
    {
        //DAD6D6
        return UIColor(red: 218.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1)
    }
    
    
    static var myMatteGold: UIColor
    {
        //F7CB15
        return UIColor(red: 247.0/255.0, green: 203.0/255.0, blue: 21.0/255.0, alpha: 1)
    }
    
    static var twitterBlue: UIColor
    {
        //00aced
        return UIColor(red: 0.0/255.0, green: 172.0/255.0, blue: 237.0/255.0, alpha: 1)
    }
}

