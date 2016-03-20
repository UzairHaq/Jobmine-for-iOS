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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        cell.textLabel?.text = "rows"
        
        return cell
    }
}
