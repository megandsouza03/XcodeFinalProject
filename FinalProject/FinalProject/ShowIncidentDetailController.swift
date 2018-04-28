//
//  ShowIncidentDetailController.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/27/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import Eureka
import ViewRow

class ShowIncidentDetailController: FormViewController {
    var incidents : incidents?
    override func viewDidLoad() {
        super.viewDidLoad()
        form
         +++ Section("Report Type")
            <<< LabelRow() {
                (row) in
                row.title = "Type"
                row.value = incidents?.TypeIncident
                row.disabled = true
            }
        
         
            
            +++ Section("Priority")
            <<< LabelRow() {
                (row) in
                row.title = "Priority"
                row.value = incidents?.Priority
                row.disabled = true
        }
            
            +++ Section("Description")
            <<< LabelRow() {
                (row) in
                row.title = "Description"
                row.value = incidents?.Descriptions
                row.disabled = true
            }
        
        +++ Section("Media")
            <<< ViewRow<UIImageView>()
                .cellSetup { (cell, row) in
                    //  Construct the view for the cell
                    cell.view = UIImageView()
                    cell.contentView.addSubview(cell.view!)
                    
                    //  Get something to display
                    //let image = UIImage(named: "trees")
                   // cell.view!.image = image
                    if let profileImageUrl = self.incidents?.ImageUrl {
                        cell.view?.loadImageUsingCacheWithUrlString(profileImageUrl)
                                      }
                    
                    
                    //  Make the image view occupy the entire row:
                    cell.viewRightMargin = 0.0
                    cell.viewLeftMargin = 0.0
                    cell.viewTopMargin = 0.0
                    cell.viewBottomMargin = 0.0
                    
                    //  Define the cell's height
                    cell.height = { return CGFloat(300) }
        }
            +++ Section("Location")
            <<< LabelRow() {
                (row) in
                row.title = "Latitude"
                row.value = incidents?.Latitude
                row.disabled = true
            }
            <<< LabelRow() {
                (row) in
                row.title = "Longitude"
                row.value = incidents?.Longitude
                row.disabled = true
        }
            <<< ButtonRow{
                row in
                row.title = "Show in 🌍"
                }.onCellSelection({ (cell, row) in

//                    let dest = self.performSegue(withIdentifier: "showInMaps", sender: self) as? ShowInMapsViewController
//
//                    dest?.incid = self.incidents
                    
                   
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "showInMaps") as! ShowInMapsViewController
                        controller.incid = self.incidents
                  //  self.present(controller, animated: true, completion: nil)
                    _ = self.navigationController?.pushViewController(controller, animated: true)
                    

                    
                    

        })
        
        
        
        
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
