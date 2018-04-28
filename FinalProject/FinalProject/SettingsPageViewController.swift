//
//  SettingsPageViewController.swift
//  FinalProject
//
//  Created by karan magdani on 4/12/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import Firebase
import Eureka
import ImageRow
import FirebaseAuth
import ViewRow

class SettingsPageViewController: FormViewController {
    var data : Data?
     var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        data = try? Data(contentsOf: (Auth.auth().currentUser?.photoURL)!)
        self.navigationItem.hidesBackButton = true
       // let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SettingsPageViewController.back(_:)))
    
      //self.navigationItem.leftBarButtonItem = newBackButton
        formInsert()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //     override func viewDidLoad {
    @IBAction func back(_ sender: Any) {
        print("YOO")
        dismiss(animated: true, completion: nil)
        
    }
  
    func formInsert(){
        
        
        print("form Insert")
        form
            +++ Section("Profile")
            <<< ViewRow<UIImageView>()
                .cellSetup { (cell, row) in
                    //  Construct the view for the cell
                    cell.view = UIImageView()
                    cell.contentView.addSubview(cell.view!)
                    cell.view?.image = UIImage(data: self.data!)
                    
                    
                    
                    
                    //  Make the image view occupy the entire row:
                    cell.viewRightMargin = 1.0
                    cell.viewLeftMargin = 1.0
                    cell.viewTopMargin = 1.0
                    cell.viewBottomMargin = 1.0
                    
                    //  Define the cell's height
                    cell.height = { return CGFloat(300) }
            }
            <<< TextRow ("Name"){row in
                row.title = "Name"
                row.value = (Auth.auth().currentUser?.displayName)!
                row.tag = "name"
            }
            
            +++ Section("Emergency Contact")
            
            <<< PhoneRow("Emergency Contact"){
                $0.title = "Contact - 1"
                $0.tag = "Contact_1"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
        
            <<< PhoneRow("Emergency Contact"){
                $0.title = "Contact - 2"
                $0.tag = "Contact_2"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }
        
          
            +++ Section()
            <<< ButtonRow{
                row in
                row.title = "Submit"
                }.onCellSelection({ (cell, row) in
                    print(self.form.values())
                    if self.form.validate().isEmpty {
                    let formValues = self.form.values()
                    let key = self.ref?.childByAutoId().key


                    self.ref?.child("Profile Info").child(key!).child("Descriptions").setValue(formValues["name"]!)
                    self.ref?.child("Profile Info").child(key!).child("Contact-1").setValue(formValues["Contact_1"]!)
                    self.ref?.child("Profile Info").child(key!).child("Contact-2").setValue(formValues["Contact_2"]!)
                   
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                   
                    //  self.present(controller, animated: true, completion: nil)
//                    self.navigationController?.show(controller, sender: nil)
                    self.dismiss(animated: true, completion: nil)
//                    self.view.addSubview(controller.view)
                    }
                    else{
                        let alert = UIAlertController(title: "Error Message", message: "Please Enter all the Values", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        
                        
                        self.present(alert, animated: true)
                        
                    }
                    
                    
                })
            <<< ButtonRow{
                row in
                row.title = "Back"
                }.onCellSelection({ (row,cell) in
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                
                    self.dismiss(animated: true, completion: nil)
                })
        
        
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
