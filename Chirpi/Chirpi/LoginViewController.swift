//
//  LoginViewController.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/19/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import Spring

class LoginViewController: UIViewController
{
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var chirpiImg: SpringImageView!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var bigChirpi: SpringImageView!
    @IBOutlet weak var chirpiLabel: UILabel!
    
    var timer = Timer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //setGradientLayer()
        
        chirpiImg.image = UIImage(named: "Chirpi")?.withRenderingMode(.alwaysTemplate)
        
        self.loginBtn.layer.cornerRadius = 40
        self.loginBtn.layer.borderColor = UIColor.twitterBlue.cgColor
        self.loginBtn.layer.borderWidth = 4
        
        self.viewBack.alpha = 0
        
        self.chirpiImg.isHidden = true
        
        animateChirpi()
    }
    
    func setGradientLayer()
    {
        let bottomColor = UIColor.myOffWhite
        let topColor = UIColor.myTimberWolf
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.viewBack.bounds
        self.viewBack.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func animateChirpi()
    {
        self.bigChirpi.animation = "zoomOut"
        self.bigChirpi.curve = "easeOutQuart"
        self.bigChirpi.duration = 2.0
        self.bigChirpi.damping = 0.7
        self.bigChirpi.delay = 1
        
        self.bigChirpi.animateToNext
        {
            self.bigChirpi.isHidden = true
            
            self.viewBack.alpha = 0
            
            UIView.animate(withDuration: 1.5, animations: {
                self.chirpiLabel.transform = CGAffineTransform(translationX: 0, y: -396)
                
                 self.viewBack.alpha = 1
             }, completion: { (true) in
                self.chirpiImg.isHidden = false
                self.chirpiImg.animation = "slideRight"
                self.chirpiImg.curve = "easeOutQuart"
                self.chirpiImg.duration = 2.0
                self.chirpiImg.damping = 0.7
                self.chirpiImg.animate()
                
                self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.smallChirpin), userInfo: nil, repeats: true)
                self.timer.fire()
            })
        }
    }

    func smallChirpin()
    {
        self.chirpiImg.animation = "swing"
        self.chirpiImg.curve = "easeOutQuart"
        self.chirpiImg.duration = 1.0
        self.chirpiImg.damping = 0.7
        self.chirpiImg.animate()
    }
    
    @IBAction func loginPressed(_ sender: Any)
    {
        self.timer.invalidate()
        
        self.chirpiImg.animation = "slideLeft"
        self.chirpiImg.curve = "easeOutQuart"
        self.chirpiImg.duration = 2.0
        self.chirpiImg.damping = 0.7
        
        self.chirpiImg.animateToNext
        {
            self.chirpiImg.isHidden = true
            
            let client = TwitterClient.sharedInstance
            
            client?.login(success: {
                
                print("Logged In.")
                self.performSegue(withIdentifier: "loginSegue", sender: self)
                
            }, failure: { (error: Error) in
                print("Error: \(error.localizedDescription)")
            })
        }
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
