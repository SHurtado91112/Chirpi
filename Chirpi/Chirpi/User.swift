//
//  User.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/19/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class User: NSObject
{
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var profileBannerURL: URL?
    
    var tagline: String?
    var profileColor: String?
    
    var favCount: Int!
    var followingCount: Int!
    var followerCount: Int!
    
    var dictionary: NSDictionary?
    
    static let userDidLogOutNotification = "UserDidLogOut"
    
    init(dictionary: NSDictionary)
    {
        self.dictionary = dictionary
        
        print("SECRET2: \(dictionary)")
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        favCount = dictionary["favourites_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        followerCount = dictionary["followers_count"] as? Int
        
        profileColor = dictionary["profile_link_color"] as? String
        
        let profileBanString = dictionary["profile_banner_url"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        
        if(profileBanString != nil)
        {
            profileBannerURL = URL(string: profileBanString!)
        }
        
        if(profileURLString != nil)
        {
            profileURL = URL(string: profileURLString!)
        }
        
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser : User?
    
    class var currentUser : User?
    {
        get
        {
            if(_currentUser == nil)
            {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData
                {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
    
        set(user)
        {
            
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user
            {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }
            else
            {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
    
}
