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
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?

    let client = TwitterClient.sharedInstance
    
    @IBOutlet weak var logNavBarBtn: UIBarButtonItem!
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setUpInfiniteIndicator()
        
        self.logNavBarBtn.tintColor = UIColor.myOffWhite
        
        self.logNavBarBtn.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir Next", size: 16)!], for: .normal)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        print(User.currentUser?.name! as String!)
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.myOnyxGray
        
        client?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(refreshControl, at: 0)
    }
    
    func setUpInfiniteIndicator()
    {
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        self.tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl)
    {
        
        client?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            
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
    
    @IBAction func logOutPressed(_ sender: Any)
    {
        TwitterClient.sharedInstance?.logOut()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if (!isMoreDataLoading)
        {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging)
            {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()

                
                loadMoreData()
            }
        }
    }
    
    func loadMoreData()
    {
        // Configure session so that completion handler is executed on main UI thread
        client?.homeTimelineWithIncrease(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            // Update flag
            self.isMoreDataLoading = false
            
            // Stop the loading indicator
            self.loadingMoreView!.stopAnimating()
            
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
            self.loadingMoreView!.stopAnimating()
        })
        
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

class InfiniteScrollActivityView: UIView {
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    static let defaultHeight:CGFloat = 60.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActivityIndicator()
    }
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        setupActivityIndicator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.activityIndicatorViewStyle = .white
        
        activityIndicatorView.color = UIColor.myOnyxGray
        
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
    }
    
    func stopAnimating() {
        self.activityIndicatorView.stopAnimating()
        self.isHidden = true
    }
    
    func startAnimating() {
        self.isHidden = false
        self.activityIndicatorView.startAnimating()
    }
}
