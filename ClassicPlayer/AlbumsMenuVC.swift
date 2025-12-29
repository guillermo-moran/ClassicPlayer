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
    
    private let NO_ALBUMS = "No Albums"
    
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
        
        menuTable.reloadData()
        if !albumsArray.isEmpty {
            currentIndexPath = IndexPath(row: min(currentIndexPath.row, albumsArray.count - 1), section: 0)
            self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: .none)
        }
        
        //self.menuTable(self.tableView, didSelectRowAt: indexPath)
        
        // Do any additional setup after loading the view.
    }
    
    func loadAlbums() {
        let query = MPMediaQuery.albums()
        if let albums = query.collections, albums.isEmpty == false {
            for item in albums {
                let album = item.representativeItem
                let albumName = album?.albumTitle ?? NO_ALBUMS
                let artistName = (album?.albumArtist?.isEmpty == false) ? album!.albumArtist! : "Unknown Artist"
                let artwork = album?.artwork?.image(at: CGSize(width: 70, height: 70)) ?? #imageLiteral(resourceName: "no_art")

                albumsArray.append(albumName)
                artistsArray.append(artistName)
                artworkArray.append(artwork)
            }
        } else {
            // No albums available
            albumsArray = [NO_ALBUMS]
            artistsArray = [""]
            artworkArray = [#imageLiteral(resourceName: "no_art")]
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
        guard !albumsArray.isEmpty else { return }
        var nextIndex = currentIndexPath.row - 1
        if nextIndex < 0 { nextIndex = 0 }
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: .none)
        menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: true)
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        guard !albumsArray.isEmpty else { return }
        var nextIndex = currentIndexPath.row + 1
        let maxIndex = max(albumsArray.count - 1, 0)
        if nextIndex > maxIndex { nextIndex = maxIndex }
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: .none)
        menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: true)
    }
    
    func clickWheelClicked(notification: Notification){
        guard !albumsArray.isEmpty else { return }
        if albumsArray.count == 1 && albumsArray.first == NO_ALBUMS { return }
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
        if albumsArray.count == 1 && albumsArray.first == NO_ALBUMS { return }
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
        
        if albumsArray.count == 1 && albumsArray.first == NO_ALBUMS {
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.cellTitleLabel.textColor = UIColor.gray
            cell.cellSubtitleLabel.text = ""
        } else {
            cell.selectionStyle = .default
            cell.isUserInteractionEnabled = true
            cell.cellTitleLabel.textColor = UIColor.black
        }
        
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
