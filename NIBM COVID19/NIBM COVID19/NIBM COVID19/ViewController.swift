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


class ViewController:

    UIViewController

{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class HomeUIiewController:

    UIViewController

{
    private let locationManager = CLLocationManager()

    @IBOutlet weak var textLabel: UILabel!
    
    
    
    @IBOutlet weak var nibmmapnew: MKMapView!
    
    @IBOutlet weak var notifyview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifyview.layer.cornerRadius = 8    

        
              
       // Set initial location in NIBM
        _ = CLLocation(latitude: 6.9063951, longitude: 79.8684273)
              
        
    }

}


class UpdateUIiewController:

    UIViewController

{

    @IBOutlet weak var updateButton: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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







