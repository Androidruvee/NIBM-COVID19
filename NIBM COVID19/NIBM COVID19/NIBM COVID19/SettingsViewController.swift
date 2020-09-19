//
//  SettingsViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/18/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {


    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profileText: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     logoutButton.layer.borderWidth = 1
      logoutButton.layer.borderColor = UIColor.black.cgColor
      logoutButton.layer.cornerRadius = 10.0

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(UserDefaults.standard.bool(forKey: "is_logged")){
            profilePic.isHidden = false
            profileText.isHidden = false
            profileButton.isHidden = false
            logoutButton.isHidden = false}
    }
    

    @IBAction func logoutBtn(_ sender: UIButton) {
       do {
        try Auth.auth().signOut()
        UserDefaults.standard.set("null", forKey: "id")
        UserDefaults.standard.set("null", forKey: "email")
        UserDefaults.standard.set("null", forKey: "password")
        UserDefaults.standard.set(false, forKey: "is_logged")
        
        profilePic.isHidden = true
        profileText.isHidden = true
        profileButton.isHidden = true
        logoutButton.isHidden = true
       } catch let signOutError as NSError {
         print ("Error signing out: %@", signOutError)
       }
        
    }
    
}
