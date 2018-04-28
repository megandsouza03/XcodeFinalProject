//
//  incidents.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/26/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit

class incidents: NSObject {
    
    var DateSubmitted : String?
    var Descriptions: String?
    var Latitude : String?
   var Longitude : String?
    var Priority : String?
    var TypeIncident : String?
    var ImageUrl: String?
    init(ImageUrl:String,DateSubmitted:String,Descriptions:String,Longitude:String,Latitude:String,Priority:String,TypeIncident:String){
        self.DateSubmitted = DateSubmitted
        self.Descriptions = Descriptions
        self.Latitude = Latitude
        self.Longitude = Longitude
        self.Priority = Priority
        self.TypeIncident = TypeIncident
        self.ImageUrl  = ImageUrl
        
    }
}

