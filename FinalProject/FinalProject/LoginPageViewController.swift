//
//  LoginPageViewController.swift
//  FinalProject
//
//  Created by karan magdani on 4/15/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase


class LoginPageViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let speedTestController: SpeedTest = SpeedTest()
        speedTestController.checkForSpeedTest()
//        self.authUI

        // Do any additional setup after loading the view.
        setupGoogleButtons()
        
    }
    
    fileprivate func setupGoogleButtons(){
        //Add google sign in button
        print("I CAME HERE YAY")
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: view.frame.height-200, width: view.frame.width - 32, height: 100)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate = self
        
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
