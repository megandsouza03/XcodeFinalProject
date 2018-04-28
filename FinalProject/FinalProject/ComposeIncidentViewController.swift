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
    var countReport : UInt!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       

     }
    
    //TODO how to get the selected value
    //TODO how to get the selected image
    
    func formInsert(){
   
        
        print("form Insert")
        form
            +++ Section("Report Description")
            
            <<< SegmentedRow<String>("Type"){
                $0.options = ["Incident", "Accident"]
                $0.title = "Types"
                $0.value = "Incident"
                $0.tag = "Types"
                
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }

            
            <<< TextAreaRow(){ row in
                row.placeholder = "Enter Desciption"
                row.tag = "Desciption"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
               
            }
            <<< SegmentedRow<String>("Media"){
                //$0.title = "Select Media"
                $0.options = ["Library", "Camera"]
                $0.title = "Media"
                $0.value = "Camera"
                $0.tag = "selMedia"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                
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
                $0.tag = "MediaSelected1"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                
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
                 $0.tag = "MediaSelected2"
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
                row.tag = "Date"
                
            }
            
            
            
            +++ Section("Priority")
            <<< ActionSheetRow<String>() {
                $0.title = "Priority"
                $0.selectorTitle = "Priority"
                $0.options = ["High","Medium","Low"]
                $0.value = "Medium"    // initially selected
                $0.tag = "Priority"
        }
        
            +++ Section("Location")
            <<< TextRow(){ row in
                row.title = "Latitude"
                row.value = String(location.coordinate.latitude)
                row.disabled = true
                row.tag = "Location"
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
                    if self.form.validate().isEmpty {
                    print(self.form.values())
                    let formValues = self.form.values()
                    let key = self.ref?.childByAutoId().key
                    let imageName = NSUUID().uuidString
                    let storageRef = Storage.storage().reference().child("image").child("\(imageName).png")
                    //let img = UIImage(contentsOfFile: formValues["MediaSelected1"] as! String)
                        
                        if let img = formValues["MediaSelected1"]{
                            if let uploadData = UIImagePNGRepresentation(img as! UIImage) {
                                print("I came to images")
                                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                                    
                                    if let error = error {
                                        print(error)
                                        return
                                    }
                                    
                                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                                        
                                        self.ref?.child("Incident Reports").child(key!).child("MediaSelected").setValue(profileImageUrl)
                                    }
                                })
                            }
                        }else if let img = formValues["MediaSelected2"]{
                            if let uploadData = UIImagePNGRepresentation(img as! UIImage) {
                                print("I came to images")
                                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                                    
                                    if let error = error {
                                        print(error)
                                        return
                                    }
                                    
                                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                                        
                                        self.ref?.child("Incident Reports").child(key!).child("MediaSelected").setValue(profileImageUrl)
                                    }
                                })
                            }
                        }
//                        if let uploadData = UIImagePNGRepresentation(formValues["MediaSelected1"]! as! UIImage) {
//                            print("I came to images")
//                            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
//
//                                if let error = error {
//                                    print(error)
//                                    return
//                                }
//
//                                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
//
//                                    self.ref?.child("Incident Reports").child(key!).child("MediaSelected").setValue(profileImageUrl)
//                                }
//                            })
//                        }else if let uploadData = UIImagePNGRepresentation(formValues["MediaSelected2"]! as! UIImage) {
//                        print("I came to images")
//                        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
//
//                            if let error = error {
//                                print(error)
//                                return
//                            }
//
//                            if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
//
//                                self.ref?.child("Incident Reports").child(key!).child("MediaSelected").setValue(profileImageUrl)
//                            }
//                        })
//                        }
                    
              //   print(type(of: formValues["MediaSelected1"]!))
                    
               //     self.ref?.child("Incident Reports").child(key!).child("Image").setValue(formValues["MediaSelected1"]!)
                    self.ref?.child("Incident Reports").child(key!).child("Descriptions").setValue(formValues["Desciption"]!)
                    self.ref?.child("Incident Reports").child(key!).child("TypeIncident").setValue(formValues["Types"]!)
                 //   self.ref?.child("Incident Reports").child("MediaSelected1").setValue(formValues["MediaSelected1"]!)
                    self.ref?.child("Incident Reports").child(key!).child("DateSubmitted").setValue(formValues["Date"]!)
                    self.ref?.child("Incident Reports").child(key!).child("Priority").setValue(formValues["Priority"]!)
                    self.ref?.child("Incident Reports").child(key!).child("Latitude").setValue(formValues["Location"]!)
                    self.ref?.child("Incident Reports").child(key!).child("Longitude").setValue(formValues["Longitude"]!)
                    _ = self.navigationController?.popToRootViewController(animated: true)
                    }
                    else{   let alert = UIAlertController(title: "Error Message", message: "Please Enter all the Values", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                        
                        self.present(alert, animated: true)}
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
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
        formInsert()
        
        
    }
   
}
