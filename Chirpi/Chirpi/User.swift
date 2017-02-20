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
    var tagline: String?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary)
    {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileURLString = dictionary["profile_image_url_https"] as? String
        
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
                
                if(userData != nil)
                {
                    let dictionary = try! JSONSerialization.data(withJSONObject: userData, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
    
        set(user)
        {
            
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if(user != nil)
            {
                let data = try! JSONSerialization.data(withJSONObject: user?.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }
            else
            {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
    
}
