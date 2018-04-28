//
//  IncidentsViewTableController.swift
//  FinalProject
//
//  Created by Megan Dsouza on 4/26/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import Firebase
class IncidentsViewTableController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var ref:DatabaseReference?
    var dbHandle: DatabaseHandle?
    var List : [incidents] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("or was i called first table")
        print(  SingetonIncidents.incidentsList.count)
    
        var cell = tableView.dequeueReusableCell(withIdentifier: "IncidentCell") as! IncidentsTableViewCell
        cell.title.text = List[indexPath.row].Descriptions
        cell.detail.text = List[indexPath.row].TypeIncident
        
        return cell
    }
    
    func fetchData(){
//        print("was i called first fetch")
        
        
        ref = Database.database().reference()
        
        dbHandle = ref?.child("Incident Reports").observe(.childAdded, with: { (snapshot) in
         //  print("Hello")
                if let dictionary = snapshot.value as? NSDictionary{
               // print("Hello")
                let desc = dictionary["Descriptions"] as? String ?? ""
                let date = dictionary["DateSubmitted"] as? String ?? ""
                let lat = dictionary["Latitude"] as? String ?? ""
                let long = dictionary["Longitude"] as? String ?? ""
                let pri = dictionary["Priority"] as? String ?? ""
                let type = dictionary["TypeIncident"] as? String ?? ""
                let url = dictionary["MediaSelected"] as?  String ?? ""
                // print("444444",desc)
              //  print("444444",date)
                    let i = incidents(ImageUrl:url,DateSubmitted: date, Descriptions: desc, Longitude: long, Latitude: lat, Priority: pri, TypeIncident: type)
            
                    self.List.append(i)

                self.tableView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowIncidentDetailController{

                destination.incidents = List[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        performSegue(withIdentifier: "showIncidentDetails", sender: self)
        
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
