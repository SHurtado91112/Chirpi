//
//  LoginViewController.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/19/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import CCAnimations

class LoginViewController: UIViewController
{
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var chirpiImg: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        chirpiImg.image = UIImage(named: "Chirpi")?.withRenderingMode(.alwaysTemplate)
        animateChirpi()
//        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(animateChirpi), userInfo: nil, repeats: true)
//        timer.fire()

        
        self.loginBtn.layer.cornerRadius = 40
        self.loginBtn.layer.borderColor = UIColor.twitterBlue.cgColor
        self.loginBtn.layer.borderWidth = 4
    }
    
    func animateChirpi()
    {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 140, startAngle: 0, endAngle:CGFloat(M_PI)*2, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.duration = 3
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath

        self.chirpiImg.layer.add(animation, forKey: nil)
    
    }

    @IBAction func loginPressed(_ sender: Any)
    {
        let client = TwitterClient.sharedInstance
        
        client?.login(success: {
            
            print("Logged In.")
            self.performSegue(withIdentifier: "loginSegue", sender: self)
            
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        
        
    }

    override func didReceiveMemoryWarning() {
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
