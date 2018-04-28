//
//  ShowInMapsViewController.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/27/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import GoogleMaps

class ShowInMapsViewController: UIViewController {
    var incid : incidents?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(incid?.Longitude)
        let lat = (incid?.Latitude as! NSString).doubleValue
        let long = (incid?.Longitude as! NSString).doubleValue
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17)
        let mapView  = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(lat, long)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Recorded Incident"
        marker.map = mapView
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
