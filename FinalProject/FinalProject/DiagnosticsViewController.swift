//
//  DiagnosticsViewController.swift
//  FinalProject
//
//  Created by karan magdani on 4/16/18.
//  Copyright © 2018 Swift Final Project. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator
import CoreMotion
import CoreBluetooth

class DiagnosticsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CBCentralManagerDelegate {
 
    @IBOutlet weak var collectionView: UICollectionView!
    var manager: CBCentralManager!
    var bluetoothLabel: String?
    
    
    
    var motionManager = CMMotionManager()
    let shapeLayer = CAShapeLayer()
    var connectedTest: String?
    let reachability = Reachability()!
    let speedTestController: SpeedTest = SpeedTest()
    override func viewDidLoad() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        super.viewDidLoad()
        customizeNavBar()
        manager = CBCentralManager()
        manager.delegate = self
//        speedTestController.checkForSpeedTest()
        self.handleCollectionViewLayout()

        
        
        
        

        
        
//        print(Interface.allInterfaces())
//        reachability.
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.startAccelerometerUpdates()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func showNetworkAnimation(){

        
        
        let label = UILabel()
//        label.text =
        let center = view.center
        //        Create track layer
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: CGFloat.pi, endAngle: -2*CGFloat.pi, clockwise: true)
//        trackLayer.backgroundColor = UIColor.darkGray.cgColor
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.white.cgColor
        trackLayer.strokeColor = UIColor.white.cgColor
        trackLayer.lineCap = kCALineCapRound
        
        trackLayer.strokeEnd = 0
        trackLayer.lineWidth = 30
        view.layer.addSublayer(trackLayer)
        
        
//        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: CGFloat.pi, endAngle: 2*CGFloat.pi, clockwise: true)x
        shapeLayer.backgroundColor = UIColor.darkGray.cgColor
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.darkGray.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 10
        
        
        view.layer.addSublayer(shapeLayer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(sender: UIBarButtonItem){
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        print("YOO")
        dismiss(animated: true, completion: nil)
        
    }
    
    func handleAnimation(_ speed: Double){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = speed/2
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "karan")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("did i come here?")
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("did i come here? 111")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if(indexPath.item == 0){
            print("Came here")
            reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    
                    print("Reachable via WiFi")
//                cell.
                    cell.cellLabel.text = "Reachable via WiFi"
                    cell.imageView.image = #imageLiteral(resourceName: "001-wifi-3")
                } else {
                    print("Reachable via Cellular")
                    cell.cellLabel.text = "Reachable via Cellular"
                    cell.imageView.image = #imageLiteral(resourceName: "011-signal-3")
                    
                }
            }
            reachability.whenUnreachable = { _ in
                print("Not reachable")
                cell.cellLabel.text = "No Internet Connection"
                cell.imageView.image = #imageLiteral(resourceName: "014-signal")
                //            self.connectionLabel.text = "No Internet Connection"
                //            self.connectionLabel.textColor = UIColor.red
            }
            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        
        } else if(indexPath.item == 1){
//            let otherViewController: SpeedTest = SpeedTest()
//            sleep(1)
            var speed = speedTestController.returnSpeedTestResult()
            let roundedSpeed = Double(round(100*speed)/100)
            cell.cellLabel.text = String(roundedSpeed) + " MB/s"
            if(roundedSpeed > 2){
            cell.imageView.image = #imageLiteral(resourceName: "network069-4g")
            }else{
                cell.imageView.image = #imageLiteral(resourceName: "network070-3g")
            }
        } else if(indexPath.item == 2){
            cell.cellLabel.text = bluetoothLabel
            cell.imageView.image = #imageLiteral(resourceName: "bluetooth-color")
        } else if(indexPath.item == 3){
            var batteryLevel: Float {
                return UIDevice.current.batteryLevel
            }
            cell.cellLabel.text = String(batteryLevel*100)+"%"
            cell.imageView.image = #imageLiteral(resourceName: "064-battery-3")
        } else if (indexPath.item == 4){
            let notificationType = UIApplication.shared.currentUserNotificationSettings!.types
            if notificationType == [] {
                print("notifications are NOT enabled")
                cell.cellLabel.text = "Notifications not enabled"
                cell.cellLabel.adjustsFontSizeToFitWidth = true
                cell.imageView.image = #imageLiteral(resourceName: "007-vibrate")
            } else {
                cell.cellLabel.text = "Notifications are enabled"
                print("notifications are enabled")
                cell.imageView.image = #imageLiteral(resourceName: "007-vibrate")
            }
        }
//        cell.layer.masksToBounds = true;
//        cell.layer.cornerRadius = 6;
        cell.imageView.tintColor = UIColor.blue
        cell.imageView.contentMode = .redraw
        cell.contentView.layer.cornerRadius = 2
        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.blue.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale

        return cell
    }
    
    func handleCollectionViewLayout(){
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5)
        
        layout.minimumInteritemSpacing = 1 //min amount of space between cells
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)
        
    }
    
    func customizeNavBar(){
        
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        if central.state == .poweredOn
        {
            print("Searching for BLE Devices")
            bluetoothLabel = "Bluetooth On"
            // Scan for peripherals if BLE is turned on
        }
        else
        {
            // Can have different conditions for all states if needed - print generic message for now, i.e. Bluetooth isn't On
            print("Bluetooth switched off or not initialized")
            bluetoothLabel = "Bluetooth Off"
        }
    }
    

    
//    func changeItemsInCollectionCells(){
//        self.collectionView.cellForItem(at: 1)?.contentView.
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
