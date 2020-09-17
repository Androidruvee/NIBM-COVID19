//
//  UpdateViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/14/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import FirebaseFirestore



class UpdateViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tempTextField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id = UserDefaults.standard.string(forKey: "id")
        
        let ref = db.collection("users").document(id!)
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                 let last_temp = document.get("last_temp")
                 let last_date = document.get("last_time")
 
                 if(last_temp != nil){
                    var str = last_temp as?  String
                    str = str!
                    self.tempLabel.text = str! + "C"
                 }
 
                 if(last_date != nil){
                    var str = last_date as?  String
                    str = str!
                    self.dateLabel.text = "Last updated: " + str!
                    self.dateLabel.isHidden = false
                 }
            } else {
                print("Document does not exist")
            }
        }
    }


    @IBAction func updateButton(_ sender: UIButton) {
        
        errorLabel.isHidden = true
        let temp = tempTextField.text!
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM-dd HH:mm"
        let datetime = format.string(from: date)
        
        print(datetime)
        print(temp)
        
        if(temp.count == 0) {
            errorLabel.text = "Please enter temperature"
            errorLabel.isHidden = false
            return
        }
        
        updateButton.isEnabled = false
        
        let id = UserDefaults.standard.string(forKey: "id")
        
        let ref = db.collection("users").document(id!)
        ref.updateData(["last_temp": temp, "last_time": datetime]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                self.errorLabel.text = "Error occured"
                self.errorLabel.isHidden = false
            } else {
                print("Document successfully updated")
                self.updateButton.isEnabled = true
                self.tempLabel.text = temp
                self.dateLabel.text = datetime
            }
        }
    
    }
   

}
