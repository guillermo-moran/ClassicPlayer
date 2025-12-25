//
//  AppDelegate.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/5/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Ensure we have a window and force Light appearance to disable system dark mode
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        window?.makeKeyAndVisible()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            //print("Not first launch.")
        } else {
            //print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.set(true, forKey: "darkMode")
            UserDefaults.standard.set(false, forKey: "soundEffects")
            
        }
        
//        if #available(iOS 13.0, *) {
            // Status bar appearance is managed per view controller in iOS 13+.
//        } else {
        UIApplication.shared.isStatusBarHidden = true
//        }
           

        
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    // MARK: - Core Data stack



    
}

