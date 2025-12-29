//
//  ArtistsMenuVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/11/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit
import MediaPlayer

@objcMembers class ArtistsMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak private var menuTable: UITableView!
    
    var menuItems : [String] = []
    
    var currentIndexPath = IndexPath(row: 0, section: 0)
    
    private let NO_ARTISTS = "No Artists"
    
    override func viewWillAppear(_ animated: Bool) {
        startListeningForClickwheelChanges()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopListeningForClickwheelChanges()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArtists()
        menuTable.delegate   = self
        menuTable.dataSource = self
        menuTable.separatorColor = .clear
        
        menuTable.reloadData()
        if !menuItems.isEmpty {
            currentIndexPath = IndexPath(row: min(currentIndexPath.row, menuItems.count - 1), section: 0)
            self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: .none)
        }
        
        //self.menuTable(self.tableView, didSelectRowAt: indexPath)
        
        // Do any additional setup after loading the view.
    }
    
    func loadArtists() {
        let query = MPMediaQuery.artists()
        if let artists = query.collections, artists.isEmpty == false {
            for item in artists {
                let artistName = item.representativeItem?.artist ?? NO_ARTISTS
                menuItems.append(artistName)
            }
        } else {
            menuItems = [NO_ARTISTS]
        }
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
        guard !menuItems.isEmpty else { return }
        var nextIndex = currentIndexPath.row - 1
        
        if nextIndex < 0 {
            nextIndex = 0
        }
        
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: true)
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        guard !menuItems.isEmpty else { return }
        var nextIndex = currentIndexPath.row + 1
        
        let maxIndex = max(menuItems.count - 1, 0)
        if nextIndex > maxIndex {
            nextIndex = maxIndex
        }
        
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: true)
    }
    
    func clickWheelClicked(notification: Notification){
        guard !menuItems.isEmpty else { return }
        if menuItems.count == 1 && menuItems.first == NO_ARTISTS { return }
        tableView(menuTable, didSelectRowAt: currentIndexPath)
    }
    
    func menuClicked(notification: Notification){
        self.navigationController!.popViewController(animated: true)
    }
    
    //end clickwheel api
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        menuTable.cellForRow(at: indexPath)?.accessoryType = .disclosureIndicator
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if menuItems.count == 1 && menuItems.first == NO_ARTISTS { return }
        //tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
    
        
        let songListMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "songListMenuVC")
            as! SongListMenuVC
        
        songListMenuVC.filter = menuItems[index]
        
        self.show(songListMenuVC, sender: nil)
        
        return;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableCell
        
        let index = indexPath.row
        
        cell.cellLabel.text = menuItems[index]
        cell.cellLabel.highlightedTextColor = UIColor.white
        
        if menuItems.count == 1 && menuItems.first == NO_ARTISTS {
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.cellLabel.textColor = UIColor.gray
        } else {
            cell.selectionStyle = .default
            cell.isUserInteractionEnabled = true
            cell.cellLabel.textColor = UIColor.black
        }
        
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

