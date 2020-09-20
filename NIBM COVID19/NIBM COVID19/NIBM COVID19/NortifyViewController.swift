//
//  NortifyViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/20/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import FirebaseFirestore

class NortifyViewController: UIViewController {

    @IBOutlet weak var pushButton: UIButton!

    @IBOutlet weak var headingText: UITextField!
    
    @IBOutlet weak var bodyText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pushButton.layer.borderWidth = 1
        pushButton.layer.borderColor = UIColor.black.cgColor
        pushButton.layer.cornerRadius = 10.0
    }
    

    @IBAction func pushBtn(_ sender: UIButton) {
        let title_text = headingText.text!
        let body_text = bodyText.text!
        
        if(title_text.count > 1 && body_text.count > 1){
            pushButton.isEnabled = false
             let db = Firestore.firestore()
            db.collection("news").document("1").setData( [
                "title": title_text,
                "body": body_text
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    self.pushButton.isEnabled = false
                    self.headingText.text = ""
                    self.bodyText.text = ""
                } else {
                    print("Document added")
                    self.pushButton.isEnabled = false
                    self.headingText.text = ""
                    self.bodyText.text = ""
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "UpdateView") as UIViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
    

}
