//
//  MainMenuVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/5/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit
import MediaPlayer


let mainMenuVC : MainMenuVC = MainMenuVC()

@objcMembers class MainMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mediaItems : [MPMediaItem] = []
    
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var menuTable: UITableView!
    
    @IBOutlet weak private var artworkPreview: UIImageView!
    
    
    var menuItems: [String] {
        var items = ["Music", "Games", "Stopwatch", "Settings", "Shuffle Songs"]
        let player = MPMusicPlayerController.systemMusicPlayer
        if player.nowPlayingItem != nil {
            items.append("Now Playing")
        }
        return items
    }

    var currentIndexPath = IndexPath(row: 0, section: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        startListeningForClickwheelChanges()
        menuTable.reloadData()
        if currentIndexPath.row >= menuItems.count {
            currentIndexPath = IndexPath(row: max(menuItems.count - 1, 0), section: 0)
        }
        if menuItems.isEmpty == false {
            menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: .none)
        }
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
        
        // Apply Liquid Glass effect to the menuTable only
        // Create a glass background behind the table
//        if #available(iOS 26.0, *) {
//            let glassEffect = UIGlassEffect(style: .clear)
//            glassEffect.tintColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.25)
//            let glassView = UIVisualEffectView(effect: glassEffect)
//            glassView.frame = menuTable.bounds
//            glassView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            menuTable.backgroundView = glassView
//        } else {
//            // Fallback for earlier iOS versions
//            let blurEffect: UIBlurEffect
//            if #available(iOS 13.0, *) {
//                blurEffect = UIBlurEffect(style: .systemThinMaterial)
//            } else {
//                // Use a broadly supported blur style on iOS 10-12
//                blurEffect = UIBlurEffect(style: .light)
//            }
//            let blurView = UIVisualEffectView(effect: blurEffect)
//            blurView.frame = menuTable.bounds
//            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            menuTable.backgroundView = blurView
//        }
        
        menuTable.backgroundColor = .white // change to clear if using blur views
        menuTable.separatorColor = .clear
        menuTable.separatorEffect = nil
        
        // Ensure any headers/footers or default backgrounds are transparent
        menuTable.backgroundColor = .white // change to clear if using blur views
        menuTable.tableHeaderView?.backgroundColor = .clear
        menuTable.tableFooterView = UIView(frame: .zero)
        menuTable.tableFooterView?.backgroundColor = .clear
        
        currentIndexPath = IndexPath(row: currentIndexPath.row, section: 0)
        
        self.menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        
        //startAnimating artwork
        animateArtwork()
        Timer.scheduledTimer(timeInterval: 45.0, target: self, selector: #selector(MainMenuVC.animateArtwork), userInfo: nil, repeats: true)
        
        //self.menuTable(self.tableView, didSelectRowAt: indexPath)

        // Do any additional setup after loading the view.
    }
    
    func animateArtwork() {
        
        loadAlbumArtwork()
        
        UIView.animate(withDuration: 29.0, animations: {() -> Void in
            
            self.artworkPreview?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 15.0, animations: {() -> Void in
                
                self.artworkPreview?.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            })
        })
        
        
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
        if nextIndex < 0 { nextIndex = 0 }
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: .none)
        menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: true)
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        var nextIndex = currentIndexPath.row + 1
        let maxIndex = max(menuItems.count - 1, 0)
        if nextIndex > maxIndex { nextIndex = maxIndex }
        currentIndexPath = IndexPath(row: nextIndex, section: 0)
        menuTable.selectRow(at: currentIndexPath, animated: false, scrollPosition: .none)
        menuTable.scrollToRow(at: currentIndexPath, at: .middle, animated: true)
    }
    
    func clickWheelClicked(notification: Notification){
        tableView(menuTable, didSelectRowAt: currentIndexPath)
    }
    
    func menuClicked(notification: Notification){
        return
    }
    
    //end clickwheel api
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = menuItems[indexPath.row]
        switch title {
        case "Music":
            performSegue(withIdentifier: "showMusicMenu", sender: nil)
        case "Settings":
            performSegue(withIdentifier: "showSettingsMenu", sender: nil)
        case "Games":
            performSegue(withIdentifier: "showGamesMenu", sender: nil)
        case "Stopwatch":
            let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC")
                as! GameVC
            
            gameVC.gameName = "stop_watch"
            gameVC.HOLD_DURATION = 0.01
            self.show(gameVC, sender: nil)
            
        case "Shuffle Songs":
            let songQueue: [MPMediaItem] = mediaItems.shuffled()
            let mediaCollection = MPMediaItemCollection(items: songQueue)
            let player = MPMusicPlayerController.systemMusicPlayer
            player.setQueue(with: mediaCollection)
            player.play()
            if let nowPlayingVC = storyboard?.instantiateViewController(withIdentifier: "nowPlayingVC") as? NowPlayingVC {
                navigationController?.pushViewController(nowPlayingVC, animated: true)
            }
        case "Now Playing":
            let player = MPMusicPlayerController.systemMusicPlayer
            if player.nowPlayingItem != nil,
               let nowPlayingVC = storyboard?.instantiateViewController(withIdentifier: "nowPlayingVC") as? NowPlayingVC {
                navigationController?.pushViewController(nowPlayingVC, animated: true)
            }
        default:
            break
        }
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
        
        // Make the cell background transparent so the blur/glass shows through
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.isOpaque = false
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func loadAlbumArtwork() {
        
        if #available(iOS 9.3, *) {
            MPMediaLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    self.mediaItems = MPMediaQuery.songs().items!
                    
                    if (self.mediaItems.count > 0) {
                        var randomIndex = Int(arc4random_uniform(UInt32(self.mediaItems.count - 1)))
                        
                        while (self.mediaItems[randomIndex].artwork?.image(at: CGSize(width: 50, height: 50)) == nil) {
                            randomIndex = Int(arc4random_uniform(UInt32(self.mediaItems.count - 1)))
                        }
                        DispatchQueue.main.async {
                            self.artworkPreview.image = self.mediaItems[randomIndex].artwork?.image(at: CGSize(width: 300, height: 340))
                           
                        }
                        
                    }
                }
            }
        }
        else { //pre 9.3
            
            self.mediaItems = MPMediaQuery.songs().items!
            
            if (self.mediaItems.count > 0) {
                var randomIndex = Int(arc4random_uniform(UInt32(self.mediaItems.count - 1)))
                
                while (self.mediaItems[randomIndex].artwork?.image(at: CGSize(width: 50, height: 50)) == nil) {
                    randomIndex = Int(arc4random_uniform(UInt32(self.mediaItems.count - 1)))
                }
                
                self.artworkPreview.image = self.mediaItems[randomIndex].artwork?.image(at: CGSize(width: 300, height: 340))
            }

            
        }
    
    
        
        //menuItems = MPMediaQuery.songs().items!
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

