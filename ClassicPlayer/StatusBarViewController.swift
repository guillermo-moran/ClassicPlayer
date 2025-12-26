//
//  StatusBarViewController.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/6/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

@objcMembers class StatusBarViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var batteryImage : UIImageView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isBatteryMonitoringEnabled = true
        self.view.backgroundColor = .black;
        timeLabel.textColor = .white;
        
//        if let image = batteryImage.image(for: .normal) {
//            batteryImage.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
//        }
        batteryImage.tintColor = .white
        
        
        updateTime()
        print("Current Battery Level: \(batteryLevel())")
        //print(batteryState())
        //run time
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(StatusBarViewController.updateTime), userInfo: nil, repeats: true)

        
        //get battery updates 
        NotificationCenter.default.addObserver(self, selector: #selector(self.batteryStateDidChange(notification:)), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.batteryLevelDidChange(notification:)), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        
        updateBatteryImage()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let dateString = formatter.string(from: Date())
 
        timeLabel.text = dateString  // "4:44 PM "
 
        
        //timeLabel.text = String(batteryLevel());
    }
    
    // function to return the devices battery level
    func batteryLevel()-> Float {
        return UIDevice.current.batteryLevel * 100
    }
    
    // function to return the devices battery state (Unknown, Unplugged, Charging, or Full)
    func batteryState()-> UIDeviceBatteryState {
        return UIDevice.current.batteryState
    }
    

    func batteryStateDidChange(notification: NSNotification){
        // The stage did change: plugged, unplugged, full charge...
        updateBatteryImage()
    }
    
    func batteryLevelDidChange(notification: NSNotification){
        // The battery's level did change (98%, 99%, ...)
        updateBatteryImage()
    }
    
    func updateBatteryImage() {
        let batteryLevel = Float(self.batteryLevel())
        let batteryState = self.batteryState()
        
        if (batteryState == .charging) {
            let img = #imageLiteral(resourceName: "battery_charging").withRenderingMode(.alwaysTemplate)
            self.batteryImage.image = img
            return
        }
        
        if (batteryLevel >= 70.0) {
            let img = #imageLiteral(resourceName: "battery_3").withRenderingMode(.alwaysTemplate)
            self.batteryImage.image = img
            
        }
        
        else if (batteryLevel >= 40.0 && batteryLevel < 70.0) {
            let img = #imageLiteral(resourceName: "battery_2").withRenderingMode(.alwaysTemplate)
            self.batteryImage.image = img
            
        }
        
        else if (batteryLevel >= 20 && batteryLevel < 40) {
            let img = #imageLiteral(resourceName: "battery_1").withRenderingMode(.alwaysTemplate)
            self.batteryImage.image = img
            
        }
        else {
            let img = #imageLiteral(resourceName: "battery_0").withRenderingMode(.alwaysTemplate)
            self.batteryImage.image = img
            
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

