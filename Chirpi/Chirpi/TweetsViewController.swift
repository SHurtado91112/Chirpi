//
//  TweetsViewController.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/19/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    var tweets : [Tweet] = []
    let client = TwitterClient.sharedInstance
    
    @IBOutlet weak var logNavBarBtn: UIBarButtonItem!
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.logNavBarBtn.tintColor = UIColor.myOffWhite
        
        self.logNavBarBtn.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir Next", size: 16)!], for: .normal)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        print("Current User: \(User.currentUser?.name!)")
        
        print(User.currentUser?.name! as String!)
        
        client?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            print("\(self.tweets[0].userName!): @\(self.tweets[0].userHandle!) \n\(self.tweets[0].text!)")
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        
        

        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(tweets.count)
        
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let tweet = self.tweets[indexPath.row]
        cell.parentView = self
        
        cell.tweet = tweet
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.selectionStyle = .none
        
//        self.performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    @IBAction func logOutPressed(_ sender: Any)
    {
        TwitterClient.sharedInstance?.logOut()
    }
    
    override func didReceiveMemoryWarning()
    {
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
