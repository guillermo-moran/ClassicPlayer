//
//  PlaylistsMenuVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/11/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit
import MediaPlayer

@objcMembers class PlaylistsMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak private var menuTable: UITableView!
    
    let NO_PLAYLISTS = "No Playlists"
    
    var menuItems : [String] = []
    
    var currentIndexPath = IndexPath(row: 0, section: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        startListeningForClickwheelChanges()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopListeningForClickwheelChanges()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlaylists()
        menuTable.delegate   = self
        menuTable.dataSource = self
        menuTable.separatorColor = UIColor.white
        
        currentIndexPath = IndexPath(row: currentIndexPath.row, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        //self.menuTable(self.tableView, didSelectRowAt: indexPath)
        
        // Do any additional setup after loading the view.
    }
    
    func loadPlaylists() {
        
        //MPMediaLibrary.requestAuthorization { (status) in
        //if status == .authorized {
        //self.runMediaLibraryQuery()
        
        /*
        let query = MPMediaQuery.playlists()
        let playlists = query.collections
        
        for (_, item) in playlists!.enumerated() {
            let playlist = item.representativeItem
            let playlistName = playlist?.albumTitle
            
            if (playlistName != nil) {
                self.menuItems.append(playlistName!)
            }
            else {
                self.menuItems.append(NO_PLAYLISTS)
                return
            }
        }
        */
        
        let myPlaylistsQuery = MPMediaQuery.playlists()
        let playlists = myPlaylistsQuery.collections
        
        for playlist in playlists! {
            let name = (playlist.value(forProperty: MPMediaPlaylistPropertyName) ?? "No name")
            self.menuItems.append(name as! String)
            
        }
        
        
        /*
         MPMediaQuery *query=[MPMediaQuery artistsQuery];
         NSArray *artists=[query collections];
         artistNames=[[NSMutableArray alloc]init];
         for(MPMediaItemCollection *collection in artists)
         {
         MPMediaItem *item=[collection representativeItem];
         [artistNames addObject:[item valueForProperty:MPMediaItemPropertyArtist]];
         }
         uniqueNames=[[NSMutableArray alloc]init];
         for(id object in artistNames)
         {
         if(![uniqueNames containsObject:object])
         {
         [uniqueNames addObject:object];
         }
         }
         */
        
        // }
        //else {
        
        //}
        
        
        
        
        //menuItems = MPMediaQuery.songs().items!
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
        
        menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: true)
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        var nextIndex = currentIndexPath.row + 1
        
        if (nextIndex > menuItems.count - 1) {
            nextIndex = menuItems.count - 1
        }
        
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: true)
    }
    
    func clickWheelClicked(notification: Notification){
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
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.29, green:0.51, blue:0.86, alpha:1.0)
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
