//
//  SettingsVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/12/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

@objcMembers class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuTable : UITableView!

    let menuItems = ["Dark Mode", "Sound Effects", "About"]
    
    var currentIndexPath = IndexPath(row: 0, section: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        startListeningForClickwheelChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopListeningForClickwheelChanges()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.delegate   = self
        menuTable.dataSource = self
        menuTable.separatorColor = UIColor.white
        
        menuTable.layer.shadowColor = UIColor.black.cgColor
        menuTable.layer.shadowOffset = CGSize(width: 0, height: 0)
        menuTable.layer.shadowRadius = 5
        menuTable.layer.shadowOpacity = 1.0
        
        menuTable.clipsToBounds = false
        menuTable.layer.masksToBounds = false
        
        
        currentIndexPath = IndexPath(row: currentIndexPath.row, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        //self.menuTable(self.tableView, didSelectRowAt: indexPath)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Clickwheel Api
    
    func stopListeningForClickwheelChanges() {
        
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("clickWheelDidMoveDown"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("clickWheelDidMoveUp"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("clickWheelClicked"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("menuClicked"), object: nil)
    }
    
    func startListeningForClickwheelChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelDidMoveDown(notification:)), name: Notification.Name("clickWheelDidMoveDown"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelDidMoveUp(notification:)), name: Notification.Name("clickWheelDidMoveUp"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelClicked(notification:)), name: Notification.Name("clickWheelClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.menuClicked(notification:)), name: Notification.Name("menuClicked"), object: nil)
    }
    
    func clickWheelDidMoveUp(notification: Notification) {
        var nextIndex = currentIndexPath.row - 1
        
        if (nextIndex < 0) {
            nextIndex = 0
        }
        
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        var nextIndex = currentIndexPath.row + 1
        
        if (nextIndex > menuItems.count - 1) {
            nextIndex = menuItems.count - 1
        }
        
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
    }
    
    func clickWheelClicked(notification: Notification){
        tableView(menuTable, didSelectRowAt: currentIndexPath)
    }
    
    func menuClicked(notification: Notification){
        self.navigationController!.popViewController(animated: true)
    }
    
    //end clickwheel api
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        let defaults = UserDefaults.standard
        
        if (index == 0) {
            let newBool = !defaults.bool(forKey: "darkMode")
            defaults.set(newBool, forKey: "darkMode")
        }
        
        if (index == 1) {
            let newBool = !defaults.bool(forKey: "soundEffects")
            defaults.set(newBool, forKey: "soundEffects")
        }
        
        if (index == 2) {
            /*
            let aboutVC = self.storyboard?.instantiateViewController(withIdentifier: "aboutVC")
                as! AboutVC
    
            self.navigationController?.pushViewController(aboutVC, animated: true)
            */
            
            let aboutScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "aboutScreenVC")
                as! AboutScreenVC
            
            aboutScreenVC.modalTransitionStyle = .flipHorizontal
            
            self.present(aboutScreenVC, animated: true, completion: nil)

        }
        
        tableView.reloadData()
        
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        
        NotificationCenter.default.post(name: Notification.Name("settingsUpdated"), object: nil)
        
    }
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 20
     }
     */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell  = UITableViewCell(style: .default, reuseIdentifier: "menuCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableCell
        
        let index = indexPath.row
        
        let defaults = UserDefaults.standard
        
        var togglePosition = false
        
        if (index == 0) {
            togglePosition = defaults.bool(forKey: "darkMode")
        }
        if (index == 1) {
            togglePosition = defaults.bool(forKey: "soundEffects")
        }
        
        if (index == 2) {
            cell.toggle?.isHidden = true
        }
        
        cell.label?.text = menuItems[index]
        cell.toggle?.isOn = togglePosition
        
        cell.label?.highlightedTextColor = UIColor.white
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.29, green:0.51, blue:0.86, alpha:1.0)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
        
        //menuItems = MPMediaQuery.songs().items!
}
