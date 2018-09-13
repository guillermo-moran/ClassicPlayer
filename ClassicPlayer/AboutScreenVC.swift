//
//  AboutScreenVC.swift
//  ClassicPlayer
//
//  Created by Guillermo Moran on 6/9/17.
//  Copyright © 2017 Guillermo Moran. All rights reserved.
//

import UIKit

class AboutScreenVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = DARK_BG

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAbout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
