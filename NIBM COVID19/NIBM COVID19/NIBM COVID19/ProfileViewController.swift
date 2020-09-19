//
//  ProfileViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/18/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    
    
    @IBOutlet weak var branch: UITextField!
    @IBOutlet weak var index: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var userTemp: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    let db = Firestore.firestore()
    let id = UserDefaults.standard.string(forKey: "id")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.layer.cornerRadius = 10.0
        
        
        let ref = db.collection("users").document(id!)
               ref.getDocument { (document, error) in
                   if let document = document, document.exists {
                        let last_temp = document.get("last_temp")
                        let first_name = document.get("first_name")
                        let last_name = document.get("last_name")
                        let index = document.get("index")
                        let branch = document.get("branch")
                    
                    if(last_temp != nil){
                        let str = last_temp as?  String
                        self.userTemp.text = str! + "C"
                    }
                    if(first_name != nil && last_name != nil){
                        let f_name = first_name as? String
                        let l_name = last_name as? String
                        self.nameLabel.text = f_name! + " " + l_name!
                        
                        self.firstName.placeholder = f_name!
                        self.lastName.placeholder = l_name!
                    }
                    if(index != nil){
                        let ind = index as? String
                        self.index.placeholder = ind!
                    }
                    if(branch != nil){
                        let brn = branch as? String
                        self.branch.placeholder = brn!
                    }
                   } else {
                       print("Document does not exist")
                   }
               }
    }
    

    @IBAction func updateBtn(_ sender: UIButton) {
        let f_name = firstName.text!
        let l_name = lastName.text!
        let ind = index.text!
        let brn = branch.text!
        
        var data: [String: String] = [:]
        
        if(f_name.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            data["first_name"] = f_name
            firstName.placeholder = f_name
            firstName.text = nil
        }
        if(l_name.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            data["last_name"] = l_name
            lastName.placeholder = l_name
            lastName.text = nil
        }
        if(ind.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            data["index"] = ind
            index.placeholder = ind
            index.text = nil
        }
        if(brn.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            data["branch"] = brn
            branch.placeholder = brn
            branch.text = nil
        }
        
        if(!data.isEmpty){
            self.updateButton.isEnabled = false
            let ref = db.collection("users").document(id!)
            ref.updateData(data){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                    self.updateButton.isEnabled = true
                } else {
                    print("Document successfully updated")
                    self.updateButton.isEnabled = true
                }
            }
       }
    }
    
}
