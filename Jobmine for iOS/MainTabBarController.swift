//
//  MainTabBarController.swift
//  Jobmine for iOS
//
//  Created by Uzair Haq on 2016-03-14.
//  Copyright © 2016 Uzair Haq. All rights reserved.
//

import UIKit
import Foundation

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if !defaults.boolForKey("session") {
            let loginController = self.storyboard?.instantiateViewControllerWithIdentifier("loginController") as! LoginViewController
            self.presentViewController(loginController, animated: true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
