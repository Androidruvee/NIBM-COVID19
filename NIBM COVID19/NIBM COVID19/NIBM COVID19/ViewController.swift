//
//  ViewController.swift
//  NIBM COVID19
//
//  Created by Ruvinda Lahiru Samaranayake on 9/12/20.
//  Copyright © 2020 Ruvinda Lahiru Samaranayake. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore


class ViewController:

    UIViewController

{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class HomeUIiewController:

    UIViewController, CLLocationManagerDelegate

{
    var locationManager: CLLocationManager?

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var nibmmapnew: MKMapView!
    
    @IBOutlet weak var notifyview: UIView!
    
    @IBOutlet weak var infectedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home did load")
        
        notifyview.layer.cornerRadius = 8
        
         locationManager = CLLocationManager()
         locationManager?.delegate = self
         locationManager?.requestAlwaysAuthorization()
        
         let db = Firestore.firestore()
           
           db.collection("users").whereField("infected", in: [true]).getDocuments() { (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: \(err)")
               } else {
                self.infectedLabel.text = String(querySnapshot!.documents.count)
               }
           }
        
       // Set initial location in NIBM
       // _ = CLLocation(latitude: 6.9063951, longitude: 79.8684273)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways || status == .authorizedWhenInUse) {
            locationManager?.startUpdatingLocation()
        } else {
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("New location is \(location)")
        }
    }

}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}







