//
//  ComposeIncidentViewController.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/22/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import Firebase
import Eureka
import ImageRow
import GoogleMaps

class ComposeIncidentViewController: FormViewController,  CLLocationManagerDelegate{

 var ref: DatabaseReference!
    var location : CLLocation = CLLocation(latitude: 0, longitude: 0)
 var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
     ref = Database.database().reference()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
     }
    
    func formInsert(){
        print("form Insert")
        form
            +++ Section("Report Description")
            
            <<< SegmentedRow<String>("Type"){
                $0.options = ["Incident", "Accident"]
                $0.title = "Type"
               $0.value = "description"
                }.onChange{ row in
                    print(row.value)
            }
            
            <<< TextAreaRow(){ row in
                row.placeholder = "Enter Desciption"
            }
            <<< SegmentedRow<String>("Media"){
                $0.title = "Select Media"
                $0.options = ["Library", "Camera"]
                $0.title = "Type"
                $0.value = "Media"
                $0.tag = "selMedia"
                
            }
            
            +++ Section("Media"){ section in
                section.hidden = Condition.function(["selMedia"], { form in
                    return !((form.rowBy(tag: "selMedia") as? SegmentedRow)?.value == "Library")
                })
                
            }
            <<< ImageRow() {
                $0.title = "Photo"
                $0.sourceTypes = .PhotoLibrary
                $0.clearAction = .no
                }
                .cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            }
            
            +++ Section("Media"){ section in
                section.hidden = Condition.function(["selMedia"], { form in
                    return !((form.rowBy(tag: "selMedia") as? SegmentedRow)?.value == "Camera")
                })
                
            }
            <<< ImageRow() {
                $0.title = "Camera"
                $0.sourceTypes = .Camera
                $0.clearAction = .no
                }
                .cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            }
            +++ Section("Date & Time")
            <<< TextRow(){ row in
                row.title = "Date & time"
                let dateformatter = DateFormatter()
                
                dateformatter.dateStyle = DateFormatter.Style.short
                
                dateformatter.timeStyle = DateFormatter.Style.short
                
                let now = dateformatter.string(from: NSDate() as Date)
                row.value = now
                row.disabled = true
                
            }
            
            
            
            +++ Section("Priority")
            <<< ActionSheetRow<String>() {
                $0.title = "Priority"
                $0.selectorTitle = "Priority"
                $0.options = ["High","Medium","Low"]
                $0.value = "Medium"    // initially selected
        }
        
            +++ Section("Location")
            <<< TextRow(){ row in
                row.title = "Latitude"
                row.value = String(location.coordinate.latitude)
                row.disabled = true
            }
            <<< TextRow(){ row in
                row.title = "Longitude"
                row.value = String(location.coordinate.longitude)
                row.disabled = true
                row.tag = "Longitude"
            }
            
            +++ Section()
            <<< ButtonRow{
                row in
                row.title = "Submit"
                }.onCellSelection({ (cell, row) in
                    print(self.form.values())
                })
        //
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
             
         print("I came here")
        location = locations.last!
        locationManager.stopUpdatingLocation()
        
        formInsert()
        
    }
   
}
