//
//  TwitterClient.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/19/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager
{
    static let sharedInstance = TwitterClient(baseURL: URL(string: KeysAndTokens.baseURL)!, consumerKey: KeysAndTokens.consumerKey, consumerSecret: KeysAndTokens.consumerSecret)
    
    var loginSuccess: (()->())?
    var loginFailure: ((Error)->())?
    
    func login(success: @escaping ()->(), failure: @escaping (Error)->())
    {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: KeysAndTokens.requestToken, method: "GET", callbackURL: URL(string: KeysAndTokens.callbackURL), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("Request Token Success")
            
            let url = URL(string: KeysAndTokens.baseURL + KeysAndTokens.authorizeURL + (requestToken?.token)!)!
            
            UIApplication.shared.open(url, options: [:], completionHandler: { (false) in
                print("I'm in.")
            })
            
        }, failure: { (error: Error?) -> Void in
            print("Error: \(error?.localizedDescription)")
            
            self.loginFailure?(error!)
        })
    }
    
    func handleOpenURL(url: URL)
    {
        let requestToken = BDBOAuth1Credential(queryString: url.query!)
        fetchAccessToken(withPath: KeysAndTokens.accessToken, method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            print("Access Token Success")
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
//            client?.currentAccount()
//            client?.homeTimeline(success: { (tweets: [Tweet]) in
//                for tweet in tweets
//                {
//                    print(tweet.text)
//                }
//                
//            }, failure: { (error: Error) in
//                print("Error: \(error.localizedDescription)")
//            })
//
        }, failure: { (error: Error?) in
            
            print("Error: \(error!)")
            self.loginFailure?(error!)
            
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: (Error) -> ())
    {
        get(KeysAndTokens.home_timeline, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            //                print("Tweets Accessed: \(response)")
            
            let dictionary = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsFromArray(dictionaries: dictionary)
            
//            print(tweets[0].text!)
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("error: \(error)")
        })

    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error)->())
    {
        get(KeysAndTokens.verify_credentials, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })

    }
}
