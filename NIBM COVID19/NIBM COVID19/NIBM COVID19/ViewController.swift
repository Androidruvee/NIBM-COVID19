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

    UIViewController, CLLocationManagerDelegate, MKMapViewDelegate

{
    var locationManager: CLLocationManager?

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var notifyview: UIView!
    
    @IBOutlet weak var infectedLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    var annotationIdentierCount = 0
    
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home did load")
        
        notifyview.layer.cornerRadius = 8
        
         locationManager = CLLocationManager()
         locationManager?.delegate = self
         locationManager?.requestAlwaysAuthorization()
         map.delegate = self
        
           
           db.collection("users").whereField("infected", in: [true]).getDocuments() { (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: \(err)")
               } else {
                self.infectedLabel.text = String(querySnapshot!.documents.count)
               }
           }
        
       // Set initial location in NIBM
        //_ = CLLocation(latitude: 6.9063951, longitude: 79.8684273)
       // center
        
        
        
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
            
            let regionRadius: CLLocationDistance = 500
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            self.map.setRegion(region, animated: true)
            let myPin = MKPointAnnotation()
            myPin.coordinate = center
            myPin.title = "Me"
            map.addAnnotation(myPin)
            
            let radius  = 500.00
            let coef = radius * 0.0000089
            let new_lat = location.coordinate.latitude + coef
            let new_lon = location.coordinate.longitude + coef / cos(location.coordinate.longitude * 0.018)
            
            print("new coord")
            print(new_lat)
            print(new_lon)
            
            db.collection("users").whereField("location", isLessThanOrEqualTo: GeoPoint(latitude: new_lat, longitude: new_lon))
                .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                     for document in querySnapshot!.documents {
                        if(document.documentID == UserDefaults.standard.string(forKey: "id")!){
                            return
                        }
                        
                        let location_temp = document.get("location")
                        //print(location_temp)
                        if(location_temp == nil){
                            return
                        }
                        let geo_location = location_temp as? GeoPoint
                        let temp_lat = Double(geo_location!.latitude)
                        let temp_lon = Double(geo_location!.longitude)
                        
                        //print(temp_lon)
                        
                        let pin = MKPointAnnotation()
                        let center = CLLocationCoordinate2D(latitude: temp_lat, longitude: temp_lon)
                        pin.coordinate = center
                        pin.title = "Infected"
                        self.map.addAnnotation(pin)
                     }
                }
            }
           
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            print("before nil")
            return nil
        }
        
        
        
        let title = annotation.title!!
        annotationIdentierCount += 1
        let iden = title + String(annotationIdentierCount)
        //print(title)
        //print(iden)
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: iden)
        
        
        if(title == "Me"){
            annotationView.image = UIImage(named: "myDot")
        } else if(title == "Infected"){
            annotationView.image = UIImage(named: "infectedDot")
        }
        
        return annotationView
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
