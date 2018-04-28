//
//  LeftMenuOptionsTableViewController.swift
//  FinalProject
//
//  Created by karan magdani on 4/15/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import FirebaseAuth

class LeftMenuOptionsTableViewController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var SignOut: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = try? Data(contentsOf: (Auth.auth().currentUser?.photoURL)!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        
        imageView.image = UIImage(data: data!)
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        name.text = "" + (Auth.auth().currentUser?.displayName)! + ""
//        imageView.image
        
        // Do any additional setup after loading the view.
    }

    @IBAction func SignOut(_ sender: Any) {
        print("YOYOYOYOYOYOY")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let lvc = LoginPageViewController()
            performSegue(withIdentifier: "signOutSegue", sender: nil)
//            view.addSubview(lvc)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
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
