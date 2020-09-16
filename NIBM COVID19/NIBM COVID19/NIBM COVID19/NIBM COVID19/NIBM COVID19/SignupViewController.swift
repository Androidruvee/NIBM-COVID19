//
//  SignupViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/14/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

        
    @IBOutlet weak var signupbutton: UIButton!
    
    @IBOutlet weak var loginbutton: UIButton!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            signupbutton.backgroundColor = UIColor.init(red: 155/255, green: 83/255, blue:119/255,alpha: 1)
            signupbutton.layer.cornerRadius = 10.0
            signupbutton.tintColor = UIColor.white
            
            loginbutton.backgroundColor = UIColor.init(red: 221/255, green: 221/255, blue:221/255,alpha: 1)
            loginbutton.layer.cornerRadius = 10.0
            loginbutton.tintColor = UIColor.black
            
            
        


    }


}
