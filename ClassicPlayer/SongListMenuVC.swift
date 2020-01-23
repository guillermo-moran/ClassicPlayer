//
//  MusicMenuVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/6/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit
import MediaPlayer

@objcMembers class SongListMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak private var menuTable: UITableView!
    @IBOutlet weak var alphabetView: UIView!
    @IBOutlet weak var alphabetViewLabel: UILabel!
    
    
    var filter : String? = ""
    
    private var isAlphabetViewShowing = false
    private var alphabetArray : [String] = ["All"]
    private var alphabetIndex = 0
    
    private var menuItems : [MPMediaItem] = []
    private var allSongsAvailable : [MPMediaItem] = []
    
    private var currentIndexPath = IndexPath(row: 0, section: 0)
    
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
        
        loadSongs(filter: filter!)
        
        //Build alphabet array
        allSongsAvailable = menuItems //make a backup copy of the original song list to build the alphabet
        buildAlphabetArray()
        print(alphabetArray)
        alphabetView.layer.cornerRadius = 5;
        alphabetView.layer.masksToBounds = true;
        
        currentIndexPath = IndexPath(row: currentIndexPath.row, section: 0)
        
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        //self.menuTable(self.tableView, didSelectRowAt: indexPath)
        
        // Do any additional setup after loading the view.
    }
    
    
    // letter must be in alphabetArray
    func searchSongs(letter : String) {
        
        
        
        if (!alphabetArray.contains(letter)) {
            return
        }
        
        self.menuItems = []
        
        if (letter == alphabetArray[0]) { //First element of alphabet array is "All"
            menuItems = allSongsAvailable
            
        }
        
        else {
            
            for song in allSongsAvailable {
                
                
                var songName = song.title!.uppercased()
                
                if (songName.hasPrefix("THE") || songName.hasPrefix("\"")) {
                    songName = songName.replacingOccurrences(of: "The", with: "")
                    songName = songName.replacingOccurrences(of: "\"", with: "")
                }
                
                
                
                if (songName.hasPrefix(letter)) {
                    self.menuItems.append(song)
                }
                
                if (letter == "#") {
                    if (songName.hasPrefix("1") || songName.hasPrefix("2") || songName.hasPrefix("3") || songName.hasPrefix("4") || songName.hasPrefix("5") || songName.hasPrefix("6") || songName.hasPrefix("7") || songName.hasPrefix("8") || songName.hasPrefix("9") || songName.hasPrefix("!") || songName.hasPrefix("?")) {
                     
                        self.menuItems.append(song)
                        
                    }
                }
                
            }
        }
        print(menuItems)
        self.menuTable.reloadData()
    }
    
    func loadSongs(filter : String) {
        
        //MPMediaLibrary.requestAuthorization { (status) in
         //   if status == .authorized {
        
                
        if (filter == "") {
                    //self.runMediaLibraryQuery()
            self.menuItems = MPMediaQuery.songs().items!
        }
            
        else {
                    
            let allSongs = MPMediaQuery.songs().items!
            print(filter)
            
            for song in allSongs {
                        
                var artistName = song.artist
                var albumName  = song.albumTitle
                
                if (artistName == nil || artistName == "") {
                    artistName = "Unknown Artist"
                }
                        
                
                if (albumName == nil || albumName == "") {
                    albumName = "Unknown Album"
                }
                        
                if (artistName == filter || albumName == filter) {
                    self.menuItems.append(song)
                    //print(song.title!)
                            
                }
                
                //Playlists Support
                let myPlaylistsQuery = MPMediaQuery.playlists()
                let playlists = myPlaylistsQuery.collections
                
                for playlist in playlists! {
                    let playlistName = (playlist.value(forProperty: MPMediaPlaylistPropertyName) ?? "No name")
                    if (filter == playlistName as! String) {
                        self.menuItems = playlist.items
                    }
                    
                }
            }
        }
    }
    
        //menuItems = MPMediaQuery.songs().items!
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //AlphabetView Stuff
    
    func setAlphabetLetter(letter : String) {
        alphabetViewLabel.text = letter
    }
    
    func toggleAlphabetView() {
      
        
        if (isAlphabetViewShowing) {
            alphabetView.isHidden = true
            isAlphabetViewShowing = false
            alphabetIndex = 0
        }
    
        else {
            
            alphabetView.isHidden = false
            isAlphabetViewShowing = true
            setAlphabetLetter(letter: alphabetArray[alphabetIndex])
        }
        
    }
    
    func buildAlphabetArray() {
        let allLetters = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "x", "Y", "Z"]
        
        let allSongs = allSongsAvailable
        
        for (_, letter) in allLetters.enumerated() {
            
            for (_, song) in allSongs.enumerated() {
                
                let songName = song.title!.uppercased()
                
                if (letter == "#") {
                    
                    if (songName.hasPrefix("1") || songName.hasPrefix("2") || songName.hasPrefix("3") || songName.hasPrefix("4") || songName.hasPrefix("5") || songName.hasPrefix("6") || songName.hasPrefix("7") || songName.hasPrefix("8") || songName.hasPrefix("9") || songName.hasPrefix("!") || songName.hasPrefix("?")) {
                        
                        alphabetArray.append(letter)
                        break
                        
                    } //end if
                } //end if letter = #
                
                if (songName.hasPrefix(letter)) {
                    alphabetArray.append(letter)
                    break
                } //end if
                
            } //end for song loop
            
            
        } //end for letter loop
        
        
    } //end function
    
    
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
    
    //Clickwheel functions
    
    func clickWheelDidMoveUp(notification: Notification) {
        
        if (isAlphabetViewShowing) {
            var newIndex = (alphabetIndex - 1) % alphabetArray.count
            if (newIndex < 0) { newIndex = (alphabetArray.count - 1) }
            alphabetIndex = newIndex
            setAlphabetLetter(letter: alphabetArray[alphabetIndex])
            return
        }
        
        var nextIndex = currentIndexPath.row - 1
        
        if (nextIndex < 0) {
            nextIndex = 0
        }
        
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.middle)
        
        //menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: false)
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        
        if (isAlphabetViewShowing) {
            let newIndex = (alphabetIndex + 1) % alphabetArray.count
            alphabetIndex = newIndex
            setAlphabetLetter(letter: alphabetArray[alphabetIndex])
            return
        }
        
        var nextIndex = currentIndexPath.row + 1
        /*
        if (nextIndex > menuItems.count - 1) {
            nextIndex = menuItems.count - 1
        }
         */
        
        // Search Cell Code
        
        
        if (nextIndex > menuItems.count) {
            nextIndex = menuItems.count
        }
 
        
        
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.middle)
        
        //menuTable.scrollToRow(at: currentIndexPath, at: .bottom, animated: false)
    }
    
    func clickWheelClicked(notification: Notification){
        if (isAlphabetViewShowing) {
            let letterToSearchFor = alphabetArray[alphabetIndex]
            
            searchSongs(letter: letterToSearchFor)
            
            toggleAlphabetView()
            
            self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.middle)
        }
        else {
            tableView(menuTable, didSelectRowAt: currentIndexPath)
        }
    }
    
    func menuClicked(notification: Notification) {
        if (isAlphabetViewShowing) {
            
            toggleAlphabetView()
        }
        else {
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    //end clickwheel api
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        menuTable.cellForRow(at: indexPath)?.accessoryType = .disclosureIndicator
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        // Search Cell Code
        
        if (indexPath.row == 0) {
            toggleAlphabetView()
            return
        }
        
        
        var songQueue : [MPMediaItem] = []
        /*
        for i in indexPath.row ... menuItems.count - 1 {
            songQueue.append(menuItems[i])
        }
        */
        
        //search cell code
        
        for i in indexPath.row ... menuItems.count {
            songQueue.append(menuItems[i - 1])
        }
        
        DispatchQueue.global().async {
            let mediaCollection = MPMediaItemCollection(items: songQueue)
            
            let player = MPMusicPlayerController.systemMusicPlayer
            player.setQueue(with: mediaCollection)
            
            player.play()
        }
        
        let nowPlayingVC = self.storyboard?.instantiateViewController(withIdentifier: "nowPlayingVC")
            as! NowPlayingVC

        
        self.navigationController?.pushViewController(nowPlayingVC, animated: true)
        
        return;
    }
    
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     //   return 50
    //}
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell  = UITableViewCell(style: .subtitle, reuseIdentifier: "musicCell")
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableCell
        
        let index = indexPath.row
        
        
        //Search Cell Code
        
        if (index == 0) {
            cell.cellTitleLabel.text = "Search"
            cell.cellSubtitleLabel.text = "Search Music Library"
            cell.cellImageView.image = #imageLiteral(resourceName: "search")
            
            cell.cellTitleLabel.highlightedTextColor = UIColor.white
            //cell.detailTextLabel?.highlightedTextColor = UIColor.white
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red:0.29, green:0.51, blue:0.86, alpha:1.0)
            cell.selectedBackgroundView = bgColorView
            
            return cell
        }
         
        let song = menuItems[index - 1]
         
        
        
        
        //let song = menuItems[index]
        
        cell.cellTitleLabel.text = song.title
        cell.cellSubtitleLabel.text = song.albumArtist
        cell.cellImageView.image = song.artwork?.image(at: CGSize(width: 70, height: 70))
        
        if (song.artwork == nil) {
            cell.cellImageView.image = #imageLiteral(resourceName: "no_art")
        }
        
        cell.cellTitleLabel.highlightedTextColor = UIColor.white
        //cell.detailTextLabel?.highlightedTextColor = UIColor.white
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.29, green:0.51, blue:0.86, alpha:1.0)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return menuItems.count
        
        //search cell code
        return menuItems.count+1
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
