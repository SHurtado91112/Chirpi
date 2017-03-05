//
//  ComposeChirpViewController.swift
//  Chirpi
//
//  Created by Steven Hurtado on 3/4/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import Spring

class ComposeChirpViewController: UIViewController {

    @IBOutlet weak var chirpTextField: UITextField!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var chirpButton: UIButton!
    
    @IBOutlet weak var chirpLimitLabel: UILabel!
    
    @IBOutlet weak var chirpiImageView: UIImageView!
    
    @IBOutlet weak var branchImageView: SpringImageView!
    
    var timer = Timer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
        self.chirpLimitLabel.textColor = UIColor.red
        self.chirpButton.isEnabled = false
        
        self.chirpTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.chirpiImageView.image = UIImage(named: "Chirpi")?.withRenderingMode(.alwaysTemplate)

        self.branchImageView.image = UIImage(named: "branch_small")?.withRenderingMode(.alwaysTemplate)
        
        self.chirpButton.layer.cornerRadius = 5
        
        self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.animateChirpi), userInfo: nil, repeats: true)
        
        self.timer.fire()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chirpiImageView.alpha = 0.0
        
        self.branchImageView.autohide = true
        
        
        UIView.animate(withDuration: 0.7) {
            self.chirpiImageView.alpha = 1.0
            self.branchImageView.alpha = 1.0
            
            self.branchImageView.duration = 0.7
            self.branchImageView.animate()
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.chirpiImageView.alpha = 1.0
        self.branchImageView.alpha = 1.0
        
        UIView.animate(withDuration: 0.3) {
            self.chirpiImageView.alpha = 0.0
            self.branchImageView.alpha = 0.0
        }
    }

    func animateChirpi()
    {
        //branchImageView
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
                self.chirpiImageView.transform = CGAffineTransform(translationX: 0.0, y: -31.0)
            
                self.branchImageView.animation = "shake"
                self.branchImageView.curve = "easeOutQuart"
                self.branchImageView.force = 0.3
                self.branchImageView.duration = 1.0
                self.branchImageView.damping = 0.7
                self.branchImageView.delay = 0.1
                self.branchImageView.animate()
            
        }) { (Bool) in
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
                self.chirpiImageView.transform = CGAffineTransform(translationX: 0.0, y: 31.0)
            }, completion: nil)
        }
        
        
    }
    
    func textFieldDidChange(_ sender: Any)
    {
        let chirpText = chirpTextField.text
        
        let numChar = chirpText?.characters.count
        
        self.chirpLimitLabel.text = "\(140 - numChar!)"
        
        
        
        if(Int(chirpLimitLabel.text!)! < 0 || Int(chirpLimitLabel.text!)! == 140)
        {
            self.chirpLimitLabel.textColor = UIColor.red
            self.chirpButton.isEnabled = false
        }
        else
        {
            self.chirpLimitLabel.textColor = UIColor.myOnyxGray
            self.chirpButton.isEnabled = true
        }
    }
    
    
    @IBAction func clearButtonPressed(_ sender: Any)
    {
        self.chirpLimitLabel.text = "\(140)"
        self.chirpLimitLabel.textColor = UIColor.red
        self.chirpButton.isEnabled = false
        self.chirpTextField.text = ""
    }
    
    @IBAction func chirpButtonPressed(_ sender: Any)
    {
        if(self.chirpButton.isEnabled)
        {
            let message = self.chirpTextField.text!.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
            
            TwitterClient.sharedInstance?.postTweet(message: message)
            
            _ = navigationController?.popViewController(animated: true)
        }
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
