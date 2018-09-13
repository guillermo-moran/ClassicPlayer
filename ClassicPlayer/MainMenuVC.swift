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

class MainMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mediaItems : [MPMediaItem] = []
    
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var menuTable: UITableView!
    
    @IBOutlet weak private var artworkPreview: UIImageView!
    
    
    let menuItems = ["Music", "Settings", "Shuffle Songs", "Now Playing"]

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
        return
    }
    
    //end clickwheel api
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        
        if (index == 0) { //Music Menu
            performSegue(withIdentifier: "showMusicMenu", sender: nil)
        }
        
        if (index == 1) { //Settings Menu
            
            performSegue(withIdentifier: "showSettingsMenu", sender: nil)
 
            
            /*
            let settingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "settingsScreenVC")
                as! SettingsScreenViewController
            
            settingsViewController.modalTransitionStyle = .flipHorizontal
            
            self.present(settingsViewController, animated: true, completion: nil)
            */
        }
        
        if (index == 2) { //Shuffle
         
            var songQueue : [MPMediaItem] = []
            
            songQueue = mediaItems.shuffled() 
            
            let mediaCollection = MPMediaItemCollection(items: songQueue)
            
            let player = MPMusicPlayerController.systemMusicPlayer()
            player.setQueue(with: mediaCollection)
            
            player.play()
            
            let nowPlayingVC = self.storyboard?.instantiateViewController(withIdentifier: "nowPlayingVC")
                as! NowPlayingVC
            
            
            self.navigationController?.pushViewController(nowPlayingVC, animated: true)
            
        }
        
        if (index == 3) { //Now Playing
            let nowPlayingVC = self.storyboard?.instantiateViewController(withIdentifier: "nowPlayingVC")
                as! NowPlayingVC
            
            let player = MPMusicPlayerController.systemMusicPlayer()
            
            if (player.nowPlayingItem != nil) {
                self.navigationController?.pushViewController(nowPlayingVC, animated: true)

            }
            
            
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
        bgColorView.backgroundColor = UIColor(red:0.29, green:0.51, blue:0.86, alpha:1.0)
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
                        
                        self.artworkPreview.image = self.mediaItems[randomIndex].artwork?.image(at: CGSize(width: 300, height: 340))
                    }
                    
                    
                }
                else {
                    
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
