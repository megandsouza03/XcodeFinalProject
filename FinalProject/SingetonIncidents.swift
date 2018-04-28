//
//  SingetonIncidents.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/26/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit

class SingetonIncidents: NSObject {
    static var incidentsList : Array<incidents> = []
    static var contact1: Int?
    static var contact2: Int?
    
    func add(newIn : incidents){
        SingetonIncidents.incidentsList.append(newIn)
    }
    func delete(atIndex : Int){
        SingetonIncidents.incidentsList.remove(at: atIndex)
    }
    
    class func storeContact1(contact : Int){
        print("YO STORED IT")
        contact1 = contact
    }
    
    class func storeContact2(contact: Int){
        contact2 = contact
    }
    
}
