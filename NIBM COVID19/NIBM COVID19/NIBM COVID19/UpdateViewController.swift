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
    
    @IBOutlet weak var newsurveyBtn: UIButton!
    
    @IBOutlet weak var surveyDate: UILabel!
    
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
                    let str = last_temp as?  String
                    self.tempLabel.text = str! + "C"
                 }
 
                 if(last_date != nil){
                    let str = last_date as?  String
                    self.dateLabel.text = "Last updated: " + str!
                    self.surveyDate.text = "Last updated: " + str!
                    self.dateLabel.isHidden = false
                    self.surveyDate.isHidden = false
                 }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        if(!UserDefaults.standard.bool(forKey: "is_logged")) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginView") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


    @IBAction func updateButton(_ sender: UIButton) {
        errorLabel.isHidden = true
        let temp = tempTextField.text!
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM-dd HH:mm"
        let datetime = format.string(from: date)
        
        if(temp.count == 0) {
            errorLabel.text = "Please enter temperature"
            errorLabel.isHidden = false
            return
        }
        
        updateButton.isEnabled = false
        
        let id = UserDefaults.standard.string(forKey: "id")
        
        let ref = db.collection("users").document(id!)
        ref.updateData([
            "last_temp": temp,
            "last_time": datetime]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                self.errorLabel.text = "Error occured"
                self.errorLabel.isHidden = false
            } else {
                print("Document successfully updated")
                
                self.tempLabel.text = temp + "C"
                self.dateLabel.text = "Last updated: " + datetime
                self.surveyDate.text = "Last updated: " + datetime
                
                self.dateLabel.isHidden = false
                self.surveyDate.isHidden = false
                
                UserDefaults.standard.set(temp, forKey: "last_temp")
                UserDefaults.standard.set(datetime, forKey: "last_time")
                
                self.updateButton.isEnabled = true
            }
        }
    
    }
    
    
    @IBAction func newSurveyBtn(_ sender: UIButton) {
        
        if(tempLabel.text != "00") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Survey01") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            errorLabel.text = "Please enter temperature first"
            errorLabel.isHidden = false
            return
        }
    }
    

}
