//
//  HomePageViewController.swift
//  FinalProject
//
//  Created by karan magdani on 4/12/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class HomePageViewController: UIViewController {
    var anyObject : Any?
    var timerSelected: Int = 15
    @IBOutlet weak var medicalEmergency: UIImageView!
    @IBOutlet weak var alertButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var incidentButton: UIImageView!
    var timer = Timer()
    var soundEffect: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        print("FUCK YEAH DID I DO IT???")
//        print(anyObject)
        print(Auth.auth().currentUser?.email)
        
        // Do any additional setup after loading the view.
    }
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func medicalButtonTapped(_ sender: Any) {
        print("I WAS TAPPED YAY")
        callNumber(phoneNumber: "6176376750")
    }
    
    @IBAction func incidentButtonTapped(_ sender: Any) {
        print("I WAS TAPPED YAY")
        callNumber(phoneNumber: "6176376750")
    }
    
    @IBAction func nupdButtonTapped(_ sender: Any) {
        print("I WAS TAPPED YAY WTF WTF WTF ")
        callNumber(phoneNumber: "6176376750")
    }

    
    @IBAction func torchButton(_ sender: Any) {
        toggleFlash()
    }
    
    
    func sideMenus() {
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
//            alertButton.target = revealViewController()
//            alertButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
    }
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
//                application.open(phoneCallURL, options: [nil], completionHandler: nil)
            }
        }
    }
    
    func signOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    

    func toggleFlash() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        
        if (device != nil) {
            if (device!.hasTorch) {
                do {
                    try device!.lockForConfiguration()
                    if (device!.torchMode == AVCaptureDevice.TorchMode.on) {
                        device!.torchMode = AVCaptureDevice.TorchMode.off
                    } else {
                        do {
                            try device!.setTorchModeOn(level: 1.0)
                        } catch {
                            print(error)
                        }
                    }
                    
                    device!.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "showHomePage" {
                
            guard let object = sender else {return}
            print(object)
//            let dvc = segue.destinationViewController as! DestinationViewController
//            dvc.objectToInject = object
        }
    }
    
    @objc func playAlarm(){
        print("CAME HERE YO")
        let path = Bundle.main.path(forResource: "iphone_alarm.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
            
            sleep(5)
            soundEffect?.stop()
            createAlert(titleText: "Timer Elapsed", messageText: "The set timer has elapsed")
        } catch {
            // couldn't load file :(
        }
    }
    

    @IBAction func scheduleTimer(_ sender: Any) {
        print("I CAME HERE YO")
        let vc = CustomAlertViewController()
        self.present(vc, animated: true)
//        createAlertView()
//        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(playAlarm), userInfo: nil, repeats: true)
        
        
    }
    
    func startTimer(interval: Double) {
        print("started timer with \(interval)")
        _ = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(playAlarm), userInfo: nil, repeats: true)
    }
    
    func createAlert(titleText: String, messageText: String){
        let alert = UIAlertView()
        alert.addButton(withTitle: "OKAY")
        alert.title = titleText
        alert.message = messageText
        alert.show()
        //        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func customizeNavBar(){
        
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
        
    }

}
