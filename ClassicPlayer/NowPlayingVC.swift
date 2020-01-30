//
//  NowPlayingVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 4/10/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit
import MediaPlayer

@objcMembers class NowPlayingVC: UIViewController {
    
    @IBOutlet weak var albumArt: UIImageView!
    
    @IBOutlet weak var songTitleLabel: UILabel!
    
    @IBOutlet weak var artistTitleLabel: UILabel!
    
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    @IBOutlet weak var songProgressBar: UIProgressView!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    
    let player = MPMusicPlayerController.systemMusicPlayer

    
    override func viewWillAppear(_ animated: Bool) {
        
        player.beginGeneratingPlaybackNotifications()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(songChanged(notification:)),
            name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange,
            object: nil)
        
        startListeningForClickwheelChanges()
        updateNPView()
       
    }

    func updateNPView() {
        
        if (player.playbackState == .playing || player.playbackState == .paused) {
            
            let currentSongPlaying = player.nowPlayingItem
            
            albumArt.image = currentSongPlaying?.artwork?.image(at: CGSize(width: 100, height: 100))
            
            if (albumArt.image == nil) {
                albumArt.image = #imageLiteral(resourceName: "no_art")
            }
            
            songTitleLabel.text = currentSongPlaying?.title
            artistTitleLabel.text = currentSongPlaying?.artist
            albumTitleLabel.text = currentSongPlaying?.albumTitle
            
            
            if (songTitleLabel.text == "") {
                songTitleLabel.text = "Untitled"
            }
            
            if (artistTitleLabel.text == "") {
                artistTitleLabel.text = "Unknown Artist"
            }
            
            if (albumTitleLabel.text == "") {
                albumTitleLabel.text = "Unknown Album"
            }
        }

    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {

        let ti = NSInteger(interval)
        let ms = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)

        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)

      return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
    
    func updateTimeElapsed() {
        
        let nowPlayingItemDuration = NSInteger((player.nowPlayingItem?.playbackDuration)!)
        let currentTime = NSInteger(player.currentPlaybackTime)
        let remainingTime = nowPlayingItemDuration - currentTime
        
        var timeElapsed : String!
        var timeRemaining : String!
        
        let timeElapsedSeconds = currentTime % 60
        let timeElapsedMinutes = (currentTime / 60) % 60
        let timeElapsedHours = (currentTime / 3600)
        
        let timeRemainingSeconds = remainingTime % 60
        let timeRemainingMinutes = (remainingTime / 60) % 60
        let timeRemainingHours = (remainingTime / 3600)
        
        if (nowPlayingItemDuration >= 3600) {
            timeElapsed = String(format: "%02d:%02d:%02d", timeElapsedHours, timeElapsedMinutes, timeElapsedSeconds)
            
            timeRemaining  = String(format: "%02d:%02d:%02d", timeRemainingHours, timeRemainingMinutes, timeRemainingSeconds)
        }
        else {
            timeElapsed = String(format: "%02d:%02d", timeElapsedMinutes, timeElapsedSeconds)

            timeRemaining = String(format: "%02d:%02d", timeRemainingMinutes, timeRemainingSeconds)
        }
        currentTimeLabel.text = timeElapsed
        totalTimeLabel.text = timeRemaining
        
        songProgressBar.progress = Float(currentTime) / Float(nowPlayingItemDuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.endGeneratingPlaybackNotifications()
       
        stopListeningForClickwheelChanges()
        
        NotificationCenter.default.removeObserver(NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Update music progress / time
        updateTimeElapsed()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimeElapsed), userInfo: nil, repeats: true)
        
            songProgressBar.transform = songProgressBar.transform.scaledBy(x: 1, y: 4)
        
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
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("songChanged"), object: nil)
    }
    
    func startListeningForClickwheelChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelDidMoveDown(notification:)), name: Notification.Name("clickWheelDidMoveDown"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelDidMoveUp(notification:)), name: Notification.Name("clickWheelDidMoveUp"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelClicked(notification:)), name: Notification.Name("clickWheelClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.menuClicked(notification:)), name: Notification.Name("menuClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.songChanged(notification:)), name: Notification.Name("songChanged"), object: nil)
    }
    
    func clickWheelDidMoveUp(notification: Notification) {
        return
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        return
    }
    
    func clickWheelClicked(notification: Notification){
        return
    }
    
    func menuClicked(notification: Notification){
        self.navigationController!.popViewController(animated: true)
        
    }
    
    func songChanged(notification: Notification){
        songProgressBar.progress = 0
        updateNPView()
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
