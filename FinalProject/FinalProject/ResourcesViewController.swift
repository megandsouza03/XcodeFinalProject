//
//  ResourcesViewController.swift
//  FinalProject
//
//  Created by karan magdani on 4/28/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit

class ResourcesViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func link1Clicked(_ sender: Any) {
        UIApplication.shared.open(URL(string : "http://my.northeastern.edu/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func link2Clicked(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://northeastern.blackboard.com/webapps/login/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func link3Clicked(_ sender: Any) {
        UIApplication.shared.open(URL(string : "https://login.transloc.com/login/?next=https%3A%2F%2Fondemand.transloc.com%2Frides")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.section)
        print(indexPath.row)
        
        if indexPath.row == 1 {
            // do something
            print("YO")
            UIApplication.shared.open(URL(string : "http://www.stackoverflow.com")!, options: [:], completionHandler: nil)
        }
        
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
