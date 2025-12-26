//
//  AlbumsMenuVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/11/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit
import MediaPlayer

@objcMembers class AlbumsMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak private var menuTable: UITableView!
    
    var albumsArray  : [String] = []
    var artistsArray : [String] = []
    var artworkArray : [UIImage] = []
    
    var currentIndexPath = IndexPath(row: 0, section: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        startListeningForClickwheelChanges()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopListeningForClickwheelChanges()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlbums()
        menuTable.delegate   = self
        menuTable.dataSource = self
        menuTable.separatorColor = .clear
        
        currentIndexPath = IndexPath(row: currentIndexPath.row, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        //self.menuTable(self.tableView, didSelectRowAt: indexPath)
        
        // Do any additional setup after loading the view.
    }
    
    func loadAlbums() {
        
        //MPMediaLibrary.requestAuthorization { (status) in
        //if status == .authorized {
        //self.runMediaLibraryQuery()
        
        
        let query = MPMediaQuery.albums()
        let albums = query.collections
        
        for (_, item) in albums!.enumerated() {
            let album = item.representativeItem
            let albumName = album?.albumTitle
            let artistName = album?.albumArtist
            
            let artwork = album?.artwork?.image(at: CGSize(width: 70, height: 70))
            self.albumsArray.append(albumName!)
            
            if (artistName == nil || artistName == "") {
                self.artistsArray.append("Unknown Artist")
            }
            else {
                self.artistsArray.append(artistName!)
            }
            
            if (artwork != nil) {
                self.artworkArray.append(artwork!)
            }
            else {
                self.artworkArray.append(#imageLiteral(resourceName: "no_art"))
            }
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
        
        if (nextIndex > albumsArray.count - 1) {
            nextIndex = albumsArray.count - 1
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
        
        songListMenuVC.filter = albumsArray[index]
        
        self.show(songListMenuVC, sender: nil)
        
        return;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableCell
        
        let index = indexPath.row
        
        cell.cellTitleLabel.text = albumsArray[index]
        cell.cellSubtitleLabel.text = artistsArray[index]
        cell.cellImageView.image = artworkArray[index]
        
        cell.cellTitleLabel.highlightedTextColor = UIColor.white
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsArray.count
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
