//
//  LocationViewController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/14.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager?;
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        manager = CLLocationManager();
        manager?.delegate = self;
        
        manager?.requestWhenInUseAuthorization();
        manager?.startUpdatingLocation();
        manager?.distanceFilter = CLLocationDistance(10);
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        
        manager?.stopUpdatingLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations");
        let location = locations[0];
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01);
        let region = MKCoordinateRegion(center: location.coordinate, span: span);
        self.mapView.setRegion(region, animated: true);
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
