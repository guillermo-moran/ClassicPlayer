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
    
    weak var timer: Timer?
    
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
        
        // Start/update the timer when the view appears
        timer?.invalidate()
        updateTimeElapsed()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimeElapsed), userInfo: nil, repeats: true)
    }

    func updateNPView() {
        
        if (player.playbackState == .playing || player.playbackState == .paused) {
            
            let currentSongPlaying = player.nowPlayingItem
            
            albumArt.image = currentSongPlaying?.artwork?.image(at: CGSize(width: 100, height: 100))
            
            if (albumArt.image == nil) {
                albumArt.image = #imageLiteral(resourceName: "no_art")
            }
            
            let title = currentSongPlaying?.title
            let artist = currentSongPlaying?.artist
            let album = currentSongPlaying?.albumTitle

            songTitleLabel.text = (title?.isEmpty == false) ? title : "Untitled"
            artistTitleLabel.text = (artist?.isEmpty == false) ? artist : "Unknown Artist"
            albumTitleLabel.text = (album?.isEmpty == false) ? album : "Unknown Album"
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
    
    @objc func updateTimeElapsed() {
        
        guard let item = player.nowPlayingItem else {
            currentTimeLabel.text = "--:--"
            totalTimeLabel.text = "--:--"
            songProgressBar.progress = 0
            return
        }

        let duration = item.playbackDuration
        guard duration.isFinite, duration > 0 else {
            currentTimeLabel.text = "00:00"
            totalTimeLabel.text = "00:00"
            songProgressBar.progress = 0
            return
        }

        let rawCurrent = player.currentPlaybackTime
        guard rawCurrent.isFinite, rawCurrent >= 0 else {
            currentTimeLabel.text = "00:00"
            totalTimeLabel.text = formatTime(duration)
            songProgressBar.progress = 0
            return
        }

        let total = Int(duration)
        let current = min(Int(rawCurrent), total)
        let remaining = max(total - current, 0)

        let showHours = total >= 3600
        let (elapsedStr, remainingStr) = formatElapsedAndRemaining(elapsed: current, remaining: remaining, showHours: showHours)

        currentTimeLabel.text = elapsedStr
        totalTimeLabel.text = remainingStr

        songProgressBar.progress = total > 0 ? Float(current) / Float(total) : 0
    }
    
    private func formatTime(_ seconds: TimeInterval) -> String {
        let total = Int(seconds)
        let s = total % 60
        let m = (total / 60) % 60
        let h = total / 3600
        if h > 0 {
            return String(format: "%02d:%02d:%02d", h, m, s)
        } else {
            return String(format: "%02d:%02d", m, s)
        }
    }

    private func formatElapsedAndRemaining(elapsed: Int, remaining: Int, showHours: Bool) -> (String, String) {
        let es = elapsed % 60
        let em = (elapsed / 60) % 60
        let eh = elapsed / 3600

        let rs = remaining % 60
        let rm = (remaining / 60) % 60
        let rh = remaining / 3600

        if showHours {
            return (
                String(format: "%02d:%02d:%02d", eh, em, es),
                String(format: "%02d:%02d:%02d", rh, rm, rs)
            )
        } else {
            return (
                String(format: "%02d:%02d", em, es),
                String(format: "%02d:%02d", rm, rs)
            )
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
        
        player.endGeneratingPlaybackNotifications()
       
        stopListeningForClickwheelChanges()
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keep the progress bar transform
        songProgressBar.transform = songProgressBar.transform.scaledBy(x: 1, y: 4)
        songProgressBar.progressTintColor = .black;
        
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
