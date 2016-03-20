//
//  MoreTableViewController.swift
//  Jobmine for iOS
//
//  Created by Uzair Haq on 2016-03-20.
//  Copyright © 2016 Uzair Haq. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeManager.colorWithKey("UICOLOR_NIGHTMODE_GRAY")
    }
    
    private func signOut() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: "session")
        
        let loginController = self.storyboard?.instantiateViewControllerWithIdentifier("loginController") as! LoginViewController
        self.presentViewController(loginController, animated: true, completion: nil)
    }
    
    // MARK: UITableView Delegate Methods
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            signOut()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        cell.textLabel?.text = "Sign Out"
        
        return cell
    }
}
