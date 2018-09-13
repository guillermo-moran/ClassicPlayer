//
//  ViewController.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/5/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

// Black Theme
// BG:    212121
// WHEEL: 303030

// White Theme
// BG:    F1F1F1
// WHEEL: C8C8C8

import UIKit
import MediaPlayer
import AudioToolbox

let CLICKWHEEL_SCROLL_MOD_VALUE = 5

let IS_PRESENTATION_MODE = true

//let VIEW_COLOR  = UIColor(red:0.22, green:0.24, blue:0.25, alpha:1.0)
//let WHEEL_COLOR = UIColor(red:0.24, green:0.26, blue:0.27, alpha:1.0)
//let TEXT_COLOR  = UIColor(red:0.22, green:0.24, blue:0.25, alpha:1.0)

let DARK_BG           = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
let DARK_WHEEL_COLOR  = UIColor(red:0.19, green:0.19, blue:0.19, alpha:1.0)

//let LIGHT_BG          = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
//let LIGHT_WHEEL_COLOR = UIColor(red:0.78, green:0.78, blue:0.78, alpha:1.0)

let LIGHT_BG = UIColor(red:0.95, green:0.96, blue:0.97, alpha:1.0)
let LIGHT_WHEEL_COLOR = UIColor(red:0.80, green:0.82, blue:0.85, alpha:1.0)

class ViewController : UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var menuScreenContainerView: UIView!
    @IBOutlet weak var clickWheel: C2AClickWheel!
    
    //override var prefersStatusBarHidden: Bool {
      //  return true
    //}
    
    var isMultipleTouchEnabled: Bool { return true }
    
    //MARK: Properties
    var counter = 0
    
   
    
    func setupClickWheel() {
        
        
        clickWheel.buttonColor = UIColor.clear
        //clickWheel.wheelColor = WHEEL_COLOR
        
        //menuButton.setTitleColor(TEXT_COLOR, for: .normal)
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 480:
                //print("iPhone Classic")
                clickWheel.arcWidth = 65;
            case 960:
                //print("iPhone 4 or 4S")
                clickWheel.arcWidth = 65;
            case 1136:
                //print("iPhone 5 or 5S or 5C")
                clickWheel.arcWidth = 65;
            case 1334:
                //print("iPhone 6 or 6S")
                clickWheel.arcWidth = 75;
            case 2208:
                //print("iPhone 6+ or 6S+")
                clickWheel.arcWidth = 85;
            default:
                clickWheel.arcWidth = 85;
                print("unknown")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.refreshView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = VIEW_COLOR
        
        //Click Wheel
        
        
        //Setup View
        
        //menuScreenContainerView.backgroundColor = UIColor.red
        self.menuScreenContainerView.layer.borderColor = UIColor.black.cgColor
        self.menuScreenContainerView.layer.borderWidth = 4.0
        self.menuScreenContainerView.layer.cornerRadius = 8.0
        self.menuScreenContainerView.clipsToBounds = true
        
        menuScreenContainerView.isUserInteractionEnabled = false
        
        //Settings Listener 
        NotificationCenter.default.addObserver(self, selector: #selector(self.settingsUpdated(notification:)), name: Notification.Name("settingsUpdated"), object: nil)
        
    }

    func settingsUpdated(notification: Notification) {
        self.refreshView()
    }
    
    func refreshView() {
        clickWheel.setNeedsDisplay()
        clickWheel.setNeedsLayout()
        
        self.setupClickWheel()
        
        
        let defaults = UserDefaults.standard
        let darkModeEnabled = defaults.bool(forKey: "darkMode")
        
        if (darkModeEnabled) {
            
            self.clickWheel.wheelColor = DARK_WHEEL_COLOR
            self.view.backgroundColor = DARK_BG
            
        }
            
        else {
            
            self.clickWheel.wheelColor = LIGHT_WHEEL_COLOR
            self.view.backgroundColor = LIGHT_BG
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action
    @IBAction func clickWheelValueChanged(_ sender: C2AClickWheel) {
        
        
        if sender.angle > counter {
            counter = sender.angle
            
            if (sender.angle % CLICKWHEEL_SCROLL_MOD_VALUE == 0) {
                postClickWheelDidMoveDownNotification()
            }
            
        }
        else {
            counter = sender.angle
            
            if (sender.angle % CLICKWHEEL_SCROLL_MOD_VALUE == 0) {
                postClickWheelDidMoveUpNotification()
            }
            
            
        }
    }
    
    // do NOT controll drag this methos to your button in Interface Builder
    // do NOT change this method name unless you also change it in
    // C2AClickWheek.layoutSubviews()!!
    @IBAction func centerClicked(_ sender: C2AClickWheel) {
        
        
        postClickWheelClickedNotification()
    }
    
    let player = MPMusicPlayerController.systemMusicPlayer()
    //let generator = UIImpactFeedbackGenerator(style: .light)

    @IBAction func menuPressed(_ sender: Any) {
        postMenuPressedNotification()
    }
    
    @IBAction func forwardPressed(_ sender: Any) {
        //generator.impactOccurred()
        self.vibrate()
        player.skipToNextItem()
        postSongChangedNotification()

    }
    
    @IBAction func rewindPressed(_ sender: Any) {
        
        //generator.impactOccurred()
        self.vibrate()
        player.skipToPreviousItem()
        postSongChangedNotification()
    }
 
    @IBAction func playPausePressed(_ sender: Any) {
        
        //generator.impactOccurred()
        self.vibrate()
        if (player.playbackState == .playing) {
            player.pause()
        }
        else {
            player.play()
        }
        
    }
    
    func postClickWheelDidMoveUpNotification() {
        
        //generator.impactOccurred()
        self.vibrate()
        NotificationCenter.default.post(name: Notification.Name("clickWheelDidMoveUp"), object: nil)
    }
    
    func postClickWheelDidMoveDownNotification() {
        //let generator = UIImpactFeedbackGenerator(style: .light)
        //generator.impactOccurred()
        self.vibrate()
        NotificationCenter.default.post(name: Notification.Name("clickWheelDidMoveDown"), object: nil)
    }
    
    func postClickWheelClickedNotification() {
        //let generator = UIImpactFeedbackGenerator(style: .medium)
        //generator.impactOccurred()
        self.vibrate()
        NotificationCenter.default.post(name: Notification.Name("clickWheelClicked"), object: nil)
    }
    
    func postMenuPressedNotification() {
        //let generator = UIImpactFeedbackGenerator(style: .heavy)
        //generator.impactOccurred()
        self.vibrate()
        NotificationCenter.default.post(name: Notification.Name("menuClicked"), object: nil)
    }
    
    func postSongChangedNotification() {
        //generator.impactOccurred()
        self.vibrate()
        NotificationCenter.default.post(name: Notification.Name("songChanged"), object: nil)
    }
    
    //taptic
    private let isDevice = TARGET_OS_SIMULATOR == 0
    
    func vibrate() {
        if isDevice {
            AudioServicesPlaySystemSound(1519)
        }
    }
    
}

