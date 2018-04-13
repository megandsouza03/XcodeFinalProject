//
//  GoogleMapsViewController.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/13/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import GoogleMaps
class GoogleMapsViewController: UIViewController , CLLocationManagerDelegate{
@IBOutlet weak var googleMaps: GMSMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Function for getting the Google Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("I came here")
        let location = locations[0]
        
        let myLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withTarget: myLocation, zoom: 16 )
        googleMaps.camera = camera
        showMarker(position: camera.target)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        googleMaps = mapView
        view.addSubview(googleMaps)
    }

    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Current Location"
        marker.snippet = "Current Location"
        marker.map = googleMaps
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
