//
//  SettingsScreenViewController.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 6/8/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

class SettingsScreenViewController: UIViewController {
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var darkModeToggle: UISwitch!
    @IBOutlet weak var soundEffectsToggle: UISwitch!
    
    //override var preferredStatusBarStyle: UIStatusBarStyle {
      //  return .lightContent
    //}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set buttons 
        let defaults = UserDefaults.standard
        
        darkModeToggle.isOn = defaults.bool(forKey: "darkMode")
        soundEffectsToggle.isOn = defaults.bool(forKey: "soundEffects")
        
        //Add button border
        aboutButton.backgroundColor = UIColor.clear
        aboutButton.layer.cornerRadius = 30
        aboutButton.layer.borderWidth = 2
        aboutButton.layer.borderColor = UIColor.darkGray.cgColor
        
        self.view.backgroundColor = DARK_BG

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissSettings(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func switchToggled(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        if (darkModeToggle == (sender as! UISwitch)) {
            let newBool = darkModeToggle.isOn
            defaults.set(newBool, forKey: "darkMode")
        }
        if (soundEffectsToggle == (sender as! UISwitch)) {
            let newBool = soundEffectsToggle.isOn
            defaults.set(newBool, forKey: "soundEffects")
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
