//
//  NewsViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/20/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import FirebaseFirestore

class NewsViewController: UIViewController {

    @IBOutlet weak var newsHeading: UILabel!
    @IBOutlet weak var newsMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         let db = Firestore.firestore()
        db.collection("news").document("1").getDocument() { (document, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if(document!.data() != nil){
                    self.newsHeading.text = document!.get("title") as? String
                    self.newsMessage.text = document!.get("body") as? String
                }
            }
        }
        
    }
    

    

}
