//
//  GoogleMapsViewConxtroller.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/13/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacesAPI
import SwiftyJSON
import Alamofire
import Firebase

enum Location{
    case startLocation
    case destinationLocation
}

class GoogleMapsViewController: UIViewController , CLLocationManagerDelegate, GMSMapViewDelegate{
@IBOutlet weak var googleMaps: GMSMapView!
@IBOutlet weak var startLocation : UITextField!
@IBOutlet weak var destinationLocation : UITextField!
var ref:DatabaseReference?
var List : [incidents] = []
    
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        fetch()
        print("11111")
        
        // Do any additional setup after loading the view.
    }
    func fetch(){
        print("I came into FETCH")
        ref = Database.database().reference()
        ref?.child("Incident Reports").observe(.childAdded, with: { (snapshot) in
            print("Hello")
            if let dictionary = snapshot.value as? NSDictionary{
               // print("Hello")
                let desc = dictionary["Descriptions"] as? String ?? ""
                let date = dictionary["DateSubmitted"] as? String ?? ""
                let lat = dictionary["Latitude"] as? String ?? ""
                let long = dictionary["Longitude"] as? String ?? ""
                let pri = dictionary["Priority"] as? String ?? ""
                let type = dictionary["TypeIncident"] as? String ?? ""
               let url = dictionary["MediaSelected"] as?  String ?? ""
                print("444444",desc)
                print("444444",date)
                let i = incidents(ImageUrl:url,DateSubmitted: date, Descriptions: desc, Longitude: long, Latitude: lat, Priority: pri, TypeIncident: type)
                
                self.List.append(i)
                
            }
            for i in self.List
            {
                print ("Heleo")
                let lat = (i.Latitude as! NSString).doubleValue
                let long = (i.Longitude as! NSString).doubleValue
                
                //  let mapView  = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                // self.view = googleMaps
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 16.0)
                let currentLocation = CLLocationCoordinate2DMake(lat, long)
                // let marker = GMSMarker(position: currentLocation)
                let marker = GMSMarker()
                marker.position = currentLocation
                marker.title = i.Descriptions
                print(i.Descriptions)
                marker.map = self.googleMaps
                self.googleMaps.camera = camera
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //Creating Markers
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Current Location"
        marker.snippet = "Current Location"
        marker.icon = GMSMarker.markerImage(with: UIColor.green)
        marker.map = googleMaps
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro to get Location : \(error)")
    }
    

    
    //Function for getting the Google Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("I came here")
    //    let location = locations[0]
//
//        let myLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//
//        let camera = GMSCameraPosition.camera(withTarget: myLocation, zoom: 16 )
//        googleMaps.camera = camera
    //    showMarker(position: camera.target)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.isMyLocationEnabled = true
//        mapView.isTrafficEnabled = true
//        googleMaps = mapView
        let location = locations.last
        

        
     //   drawPath(startLocation: location!, endLocation: locationTujuan)
        self.locationManager.stopUpdatingLocation()
        view.addSubview(googleMaps)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMaps.isMyLocationEnabled = true
        
        if(gesture){
            mapView.selectedMarker = nil
        }
    }
    
     func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) ->Bool {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)")
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    
  func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"


        let url = URL(string:"https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving")

        
      //  let url = URL(string: "http://api.sandbox.amadeus.com/v1.2/hotels/search-box?south_west_corner=42.134,7.31&north_east_corner=44.69,9.92&check_in=2018-06-28&check_out=2018-07-02&apikey=AoImFpsXDs9kx6UUBacykr9WOH5ZOUuV")
        
        let session = URLSession.shared // or let session = URLSession(configuration: URLSessionConfiguration.default)
        
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                //                if let data = data {
                //                    if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                //                      print(stringData) //JSONSerialization
                //
                //                    }
                //                }
                if(error != nil){
                    print("ERROR")
                }
                else{
                    do{ print("DATA     ",data)
                        let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! Dictionary<String,Any>
                           // print(fetchedData)
                        
                        let routes = fetchedData["routes"] as! NSArray
                        print("---------------------------------------")
                        
                  //      print(routes)
                        
                        // print route using Polyline
                        for route in routes
                        {   let r = route as! NSDictionary
                            //print(r.value(forKey: "legs"))
                            let r0 = r.value(forKey: "legs") as! NSArray
                            print("-----------------------")
                            for rw in r0{
                                let r = rw as! NSDictionary
                                
                                let re = r.value(forKey: "end_location")! as! NSDictionary
                                print(re.value(forKey: "lat")!)
                                print(re.value(forKey: "lng")!)
                     
                            }
                            let r1 = r.value(forKey: "overview_polyline") as! NSDictionary
                         //  print(r1.value(forKey: "points")!)
//                            let routeOverviewPolyline = r["overview_polyline"].dictionary
                          //  let points = routeOverviewPolyline?["points"]?.stringValue
                            
                            DispatchQueue.main.async(execute: {() -> Void in
                                print("Dispatch")
                               // self.googleMaps.clear()
                                let path = GMSPath.init(fromEncodedPath: r1.value(forKey: "points")! as! String)
                                let polyline = GMSPolyline.init(path: path)
                                print(path)
                                print("1111111")
                                print(polyline)
                                polyline.strokeWidth = 4
                                polyline.strokeColor = UIColor.red
                                polyline.map = self.googleMaps
                                //self.fetch()
                            })
                            
                            
                        }
                        
                    }
                    catch{
                        print("Error")
                    }
                }
            })
            task.resume()
        }
    }
    
    
    @IBAction func openStartLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        // selected location
        locationSelected = .startLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    
    @IBAction func openDestinationLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        // selected location
        locationSelected = .destinationLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @IBAction func showDirection(_ sender: UIButton) {
        // when button direction tapped, must call drawpath func
        
       self.drawPath(startLocation: locationStart, endLocation: locationEnd)
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

// MARK: - GMS Auto Complete Delegate, for autocomplete search location
extension GoogleMapsViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0
        )
        
        // set coordinate to text
        if locationSelected == .startLocation {
            startLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            let locationA : CLLocationCoordinate2D = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
            showMarker(position: locationA)
//            createMarker(titleMarker: "Location Start", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        } else {
            destinationLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            let locationB : CLLocationCoordinate2D = CLLocationCoordinate2DMake(place.coordinate.latitude, place.coordinate.longitude)
            showMarker(position: locationB)
//            createMarker(titleMarker: "Location End", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
        
        
        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}
