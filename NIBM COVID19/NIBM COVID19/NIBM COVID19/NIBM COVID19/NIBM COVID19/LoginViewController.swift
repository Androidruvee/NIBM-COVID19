//
//  LoginViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/14/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

        
    @IBOutlet weak var createbtn: UIButton!
    @IBOutlet weak var loginbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginbtn.backgroundColor = UIColor.init(red: 155/255, green: 83/255, blue:119/255,alpha: 1)
        loginbtn.layer.cornerRadius = 10.0
        loginbtn.tintColor = UIColor.white
        
        createbtn.backgroundColor = UIColor.init(red: 221/255, green: 221/255, blue:221/255,alpha: 1)
        createbtn.layer.cornerRadius = 10.0
        createbtn.tintColor = UIColor.black
        
    } 

    

    
}


