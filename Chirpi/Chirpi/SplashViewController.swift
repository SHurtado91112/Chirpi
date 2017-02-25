//
//  SplashViewController.swift
//  Chirpi
//
//  Created by Steven Hurtado on 2/21/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import Spring

class SplashViewController: UIViewController
{

    @IBOutlet weak var chirpiIV: SpringImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        animateChirpi()
        // Do any additional setup after loading the view.
    }

    func animateChirpi()
    {
        print("Here")
        
        let timer = Timer.scheduledTimer(timeInterval: 2.6, target: self, selector: #selector(splashUp), userInfo: nil, repeats: false)
        timer.fire()
        
        self.chirpiIV.animation = "zoomOut"
        self.chirpiIV.curve = "easeOutQuart"
        self.chirpiIV.duration = 3.0
        self.chirpiIV.damping = 0.7
        
        self.chirpiIV.animate()
    }
    
    func splashUp()
    {
        self.performSegue(withIdentifier: "splashSegue", sender: self)
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
