//
//  SurveyViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/17/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import FirebaseFirestore
import CoreLocation

var q1 = false
var q2 = false
var q3 = false
var q4 = false



class Survey1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func yes1Btn(_ sender: UIButton) {
        q1 = true
    }
    
    @IBAction func no1Btn(_ sender: UIButton) {
        q1 = false
    }
    
}


class Survey2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func yes2Btn(_ sender: UIButton) {
        q2 = true
    }
    @IBAction func no2Btn(_ sender: UIButton) {
        q2 = false
    }
    
}

class Survey3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func yes3Btn(_ sender: UIButton) {
        q3 = true
    }
    @IBAction func no3Btn(_ sender: UIButton) {
        q3 = false
    }
    
}

class Survey4ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var yes4Btn: UIButton!
    
    @IBOutlet weak var no4Btn: UIButton!
    
    var is_gps_allowed = false
    
    var gps_location: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         locationManager = CLLocationManager()
         locationManager?.delegate = self
         locationManager?.requestAlwaysAuthorization()

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways || status == .authorizedWhenInUse) {
            locationManager?.startUpdatingLocation()
            is_gps_allowed = true
        } else {
            is_gps_allowed = false
            gps_location = CLLocation(latitude: 6.9063951, longitude: 79.8684273)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("New location is \(location)")
            gps_location = location
        }
    }
    
    @IBAction func yes4Btn(_ sender: UIButton) {
        q4 = true
        action()
    }
    
    @IBAction func no4Btn(_ sender: UIButton) {
        q4 = false
        action()
    }
    
    func action(){
        var infected = false
        yes4Btn.isEnabled = false
        no4Btn.isEnabled = false
        
        let temp = UserDefaults.standard.integer(forKey: "last_temp")
        //let datetime = UserDefaults.standard.string(forKey: "last_time")
        
        if(q1 && q2 && q3 && q4 && temp >= 37){
            infected = true
        } else if(q1 && q2 && q3 && q4 && temp < 37){
            infected = true
        } else if(q4 && temp >= 37){
            infected = true
        }
        
    
        let id = UserDefaults.standard.string(forKey: "id")
        let db = Firestore.firestore()
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM-dd HH:mm"
        let datetime = format.string(from: date)
        
        let ref = db.collection("users").document(id!)
        
        if(infected){
            ref.updateData(["infected": true, "location":
                ["lon": gps_location?.coordinate.longitude,
                 "lat": gps_location?.coordinate.latitude],
                            "last_time": datetime]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Warning") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            ref.updateData(["infected": false, "location":
                ["lon": gps_location?.coordinate.longitude,
                 "lat": gps_location?.coordinate.latitude],
                            "last_time": datetime]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Safe") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

class SurveyResultGViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func callNow(_ sender: UIButton) {
    }
    
}

class SurveyResultBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func safeActions(_ sender: UIButton) {
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
    }
    
}



