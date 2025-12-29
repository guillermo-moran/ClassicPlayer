//
//  MainMusicMenuVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/10/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

@objcMembers class MusicMenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak private var menuTable: UITableView!
    
    let menuItems = ["All Music", "Artists", "Albums", "Playlists"]
    
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
        menuTable.separatorColor = .clear
        
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
        
        if (index == 0) { //All Songs
            performSegue(withIdentifier: "showAllMusic", sender: nil)
        }
        if (index == 1) { //Artists
            performSegue(withIdentifier: "showAllArtists", sender: nil)
        }
        if (index == 2) { //Albums
            performSegue(withIdentifier: "showAllAlbums", sender: nil)
        }
        if (index == 3) { //Playlists
            performSegue(withIdentifier: "showAllPlaylists", sender: nil)
        }
        
        return;
    }
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 20
     }
     */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell  = UITableViewCell(style: .default, reuseIdentifier: "menuCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableCell
        
        let index = indexPath.row
        
        cell.cellLabel.text = menuItems[index]
        cell.cellLabel.highlightedTextColor = UIColor.white
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
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
