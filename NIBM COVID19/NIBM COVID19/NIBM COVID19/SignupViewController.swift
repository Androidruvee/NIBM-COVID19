//
//  SignupViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/14/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignupViewController: UIViewController {

        
    @IBOutlet weak var signupbutton: UIButton!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var role: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cpassword: UITextField!
    @IBOutlet weak var errorlabel: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            signupbutton.backgroundColor = UIColor.init(red: 155/255, green: 83/255, blue:119/255,alpha: 1)
            signupbutton.layer.cornerRadius = 10.0
            signupbutton.tintColor = UIColor.white
            
            loginbutton.backgroundColor = UIColor.init(red: 221/255, green: 221/255, blue:221/255,alpha: 1)
            loginbutton.layer.cornerRadius = 10.0
            loginbutton.tintColor = UIColor.black
    }
    
    
    @IBAction func signupButton(_ sender: UIButton) {
        errorlabel.isHidden = true
        
        let f_name = firstname.text!
        let l_name = lastname.text!
        let _role = role.text!
        let _email = email.text!
        let _password = password.text!
        let _cpassword = cpassword.text!
        
        if(f_name.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            l_name.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            _email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            _password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            _cpassword.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            _role.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            ) {
            errorlabel.text = "Please fill all fields"
            errorlabel.isHidden = false
            return
        }
        
        if(_role == "student" || _role == "staff" || _role == "other"){

        } else {
            errorlabel.text = "Invalid option in Role"
            errorlabel.isHidden = false
            return
        }

        if(_password != _cpassword){
            errorlabel.text = "Passwords are not matching"
            errorlabel.isHidden = false
            return
        } else if(_password.count < 6){
            errorlabel.text = "Password must be at least 6 characters long"
            errorlabel.isHidden = false
            return
        }
        
        signupbutton.isEnabled = false
        loginbutton.isEnabled = false
        
        Auth.auth().createUser(withEmail: _email, password: _password) { authResult, error in
            
            if(error != nil) {
                self.errorlabel.text = "Error occured"
                self.errorlabel.isHidden = false
            }
            
            let id = authResult?.user.uid
            
            UserDefaults.standard.set(id!, forKey: "id")
            UserDefaults.standard.set(_email, forKey: "email")
            UserDefaults.standard.set(_password, forKey: "password")
            UserDefaults.standard.set(true, forKey: "is_logged")
            UserDefaults.standard.set(_role, forKey: "role")
            
            let db = Firestore.firestore()
            
            db.collection("users").document(id!).setData( [
                "first_name": f_name,
                "last_name": l_name,
                "role": _role
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }
            
            self.signupbutton.isEnabled = true
            self.loginbutton.isEnabled = true
            
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let vc = storyboard.instantiateViewController(withIdentifier: "UpdateView") as UIViewController
             self.navigationController?.pushViewController(vc, animated: true)

           
            
        }
        
        
    }
    
    
}
