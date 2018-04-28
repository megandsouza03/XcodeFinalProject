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
    
    func add(newIn : incidents){
        SingetonIncidents.incidentsList.append(newIn)
    }
    func delete(atIndex : Int){
        SingetonIncidents.incidentsList.remove(at: atIndex)
    }
    
}
