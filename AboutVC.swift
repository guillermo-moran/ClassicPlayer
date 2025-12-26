//
//  AboutVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 5/5/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

@objcMembers class AboutVC: UIViewController {
    
    @IBOutlet weak private var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        startListeningForClickwheelChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopListeningForClickwheelChanges()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    func startListeningForClickwheelChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelDidMoveDown(notification:)), name: Notification.Name("clickWheelDidMoveDown"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelDidMoveUp(notification:)), name: Notification.Name("clickWheelDidMoveUp"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickWheelClicked(notification:)), name: Notification.Name("clickWheelClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.menuClicked(notification:)), name: Notification.Name("menuClicked"), object: nil)
    }
    func clickWheelDidMoveUp(notification: Notification) {
        guard let textView = textView else { return }
        let delta: CGFloat = 150
        let topInset: CGFloat
        if #available(iOS 11.0, *) {
            topInset = textView.adjustedContentInset.top
        } else {
            topInset = textView.contentInset.top
        }
        let newY = max(textView.contentOffset.y - delta, -topInset)
        textView.setContentOffset(CGPoint(x: textView.contentOffset.x, y: newY), animated: true)
    }
    
    func clickWheelDidMoveDown(notification: Notification){
        guard let textView = textView else { return }
        let delta: CGFloat = 150
        let topInset: CGFloat
        let bottomInset: CGFloat
        if #available(iOS 11.0, *) {
            topInset = textView.adjustedContentInset.top
            bottomInset = textView.adjustedContentInset.bottom
        } else {
            topInset = textView.contentInset.top
            bottomInset = textView.contentInset.bottom
        }
        let maxOffsetY = textView.contentSize.height - textView.bounds.height + bottomInset
        let newY = min(textView.contentOffset.y + delta, max(maxOffsetY, -topInset))
        textView.setContentOffset(CGPoint(x: textView.contentOffset.x, y: newY), animated: true)
    }
    
    func clickWheelClicked(notification: Notification){
    
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

