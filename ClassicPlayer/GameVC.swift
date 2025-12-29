//
//  GameVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 12/26/25.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit
import WebKit

@objcMembers class GameVC: UIViewController {
    var gameName : String? = "" //from the html folder (i.e "bricks")
    
    var HOLD_DURATION: TimeInterval = 0.08;
    
    @IBOutlet weak private var webView: WKWebView!
    
    private func sendKey(_ key: String, code: String, keyCode: Int, sendKeyUp: Bool = true) {
        // Build JavaScript in smaller parts to avoid type-checker slowdowns and improve compatibility
        let keyEscaped = key.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "'", with: "\\'")
        let codeEscaped = code.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "'", with: "\\'")
        let keyCodeString = String(keyCode)

        // Ensure focus goes to a sensible target (body) before dispatching
        let focus = "(function(){ var b=document.body; if (b && !b.hasAttribute('tabindex')) { b.setAttribute('tabindex','-1'); } if (b && b.focus) { try { b.focus(); } catch(e) {} } })();\n"

        let header = "(function(){\n" +
        "function fire(type, key, code, keyCode){\n" +
        "  var e = new KeyboardEvent(type, {\n" +
        "    key: key, code: code, keyCode: keyCode, which: keyCode, charCode: keyCode,\n" +
        "    bubbles: true, cancelable: true\n" +
        "  });\n" +
        "  try { Object.defineProperty(e, 'keyCode', { get: function(){ return keyCode; } }); } catch (err) {}\n" +
        "  try { Object.defineProperty(e, 'which', { get: function(){ return keyCode; } }); } catch (err) {}\n" +
        "  (document.activeElement || document.body).dispatchEvent(e);\n" +
        "}\n"

        let down = "fire('keydown', '" + keyEscaped + "', '" + codeEscaped + "', " + keyCodeString + ");\n"
//        let press = "fire('keypress', '" + keyEscaped + "', '" + codeEscaped + "', " + keyCodeString + ");\n"
        let up = sendKeyUp ? ("fire('keyup', '" + keyEscaped + "', '" + codeEscaped + "', " + keyCodeString + ");\n") : ""
        let footer = "return true;\n})();"

        let js = focus + header + down + up + footer

        webView.evaluateJavaScript(js) { _, error in
            if let error = error {
                print("JS error dispatching key (\(key)): \(error)")
            }
        }
    }
    // Convenience overload using instance hold duration
    private func sendKeyTap(_ key: String, code: String, keyCode: Int) {
        sendKeyTap(key, code: code, keyCode: keyCode, holdDuration: HOLD_DURATION)
    }
    // Sends a short key press (keydown + keypress, then keyup after a small delay)
    private func sendKeyTap(_ key: String, code: String, keyCode: Int, holdDuration: TimeInterval) {
        // First send keydown (and keypress) without immediate keyup
        sendKey(key, code: code, keyCode: keyCode, sendKeyUp: false)

        // Then send keyup after a brief delay so the game loop can observe the press
        let keyEscaped = key.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "'", with: "\\'")
        let codeEscaped = code.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "'", with: "\\'")
        let keyCodeString = String(keyCode)

        let header = "(function(){\n" +
        "function fire(type, key, code, keyCode){\n" +
        "  var e = new KeyboardEvent(type, {\n" +
        "    key: key, code: code, keyCode: keyCode, which: keyCode, charCode: keyCode,\n" +
        "    bubbles: true, cancelable: true\n" +
        "  });\n" +
        "  try { Object.defineProperty(e, 'keyCode', { get: function(){ return keyCode; } }); } catch (err) {}\n" +
        "  try { Object.defineProperty(e, 'which', { get: function(){ return keyCode; } }); } catch (err) {}\n" +
        "  (document.activeElement || document.body).dispatchEvent(e);\n" +
        "}\n"

        let up = "fire('keyup', '" + keyEscaped + "', '" + codeEscaped + "', " + keyCodeString + ");\n"
        let footer = "return true;\n})();"
        let jsUp = header + up + footer

        DispatchQueue.main.asyncAfter(deadline: .now() + holdDuration) { [weak self] in
            self?.webView.evaluateJavaScript(jsUp) { _, error in
                if let error = error {
                    print("JS error dispatching keyUp (\(key)): \(error)")
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Disable music controls to allow overriding
        NotificationCenter.default.post(name: Notification.Name("replaceMusicControls"), object: nil, userInfo: ["enabled": true]);
        
        startListeningForClickwheelChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Enable music controls before closing view
        NotificationCenter.default.post(name: Notification.Name("replaceMusicControls"), object: nil, userInfo: ["enabled": false]);
        
        stopListeningForClickwheelChanges()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load local html/snake.html from the app bundle
        if let fileURL = Bundle.main.url(forResource: gameName, withExtension: "html") {
            let folderURL = fileURL.deletingLastPathComponent()
            webView.loadFileURL(fileURL, allowingReadAccessTo: folderURL)
        } else {
            assertionFailure("Could not find html/snake.html in the app bundle. Check file paths and target membership.")
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rewindClicked(notification:)), name: Notification.Name("rewindClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.forwardClicked(notification:)), name: Notification.Name("forwardClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playPauseClicked(notification:)), name: Notification.Name("playPauseClicked"), object: nil)
    }
    func clickWheelDidMoveUp(notification: Notification) {
        return;
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        return
    }
    
    func rewindClicked(notification: Notification){
        sendKeyTap("ArrowLeft", code: "ArrowLeft", keyCode: 37)
    }
    
    func forwardClicked(notification: Notification){
        sendKeyTap("ArrowRight", code: "ArrowRight", keyCode: 39)
    }
    
    func playPauseClicked(notification: Notification){
        sendKeyTap("ArrowDown", code: "ArrowDown", keyCode: 40)
    }
    
    func clickWheelClicked(notification: Notification){
        sendKey(" ", code: "Space", keyCode: 32)
    }
    
    func menuClicked(notification: Notification){
        self.navigationController!.popViewController(animated: true)
    }
    
    //end clickwheel api


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

