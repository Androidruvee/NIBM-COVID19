//
//  LoginViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/14/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {

        
    @IBOutlet weak var createbtn: UIButton!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginbtn.backgroundColor = UIColor.init(red: 155/255, green: 83/255, blue:119/255,alpha: 1)
        loginbtn.layer.cornerRadius = 10.0
        loginbtn.tintColor = UIColor.white
        
        createbtn.backgroundColor = UIColor.init(red: 221/255, green: 221/255, blue:221/255,alpha: 1)
        createbtn.layer.cornerRadius = 10.0
        createbtn.tintColor = UIColor.black
  
    }
    
    override func viewWillAppear(_ animated: Bool){
        if(UserDefaults.standard.bool(forKey: "is_logged")) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UpdateView") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    @IBAction func signinButton(_ sender: UIButton) {
        errorlabel.isHidden = true
        
        let _email = email.text!
        let _password = password.text!
        
        if(_email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            _password.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            errorlabel.text = "Please fill all fields"
            errorlabel.isHidden = false
        }
        
        loginbtn.isEnabled = false
        createbtn.isEnabled = false
        
        Auth.auth().signIn(withEmail: _email, password: _password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if(error != nil){
                self?.errorlabel.text = "Invalid E-Mail or Password"
                self?.errorlabel.isHidden = false
                self?.loginbtn.isEnabled = true
                self?.createbtn.isEnabled = true
                return
            }
            
          let id = authResult?.user.uid
          let db = Firestore.firestore()
            
            db.collection("users").document(id!).getDocument(){(document, err) in
                if let err = err {
                     print("Error getting documents: \(err)")
                } else {
                    print("sign in role")
                    print(document!.get("role")!)
                    UserDefaults.standard.set(document!.get("role")!, forKey: "role")
                }
                
            }
            
          UserDefaults.standard.set(id!, forKey: "id")
          UserDefaults.standard.set(_email, forKey: "email")
          UserDefaults.standard.set(_password, forKey: "password")
          UserDefaults.standard.set(true, forKey: "is_logged")
            
            self?.loginbtn.isEnabled = true
            self?.createbtn.isEnabled = true
            
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UpdateView") as UIViewController
        self?.navigationController?.pushViewController(vc, animated: true)
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "UpdateView")
//            self?.present(controller, animated: true, completion: nil)
        }
        
    }
    
    
}


