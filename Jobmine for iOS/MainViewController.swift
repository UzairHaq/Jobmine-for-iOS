//
//  MainTabBarController.swift
//  Jobmine for iOS
//
//  Created by Uzair Haq on 2016-03-14.
//  Copyright © 2016 Uzair Haq. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UITabBarController {
    private var navigationVC = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTabBar()
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
    
    private func setupNavigationBar() {
        navigationVC = self.parentViewController as! UINavigationController
        navigationVC.navigationBar.barTintColor = ThemeManager.colorWithKey("UICOLOR_NIGHTMODE_GRAY")
        navigationVC.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(18.0)]
        
        // No tab is selected yet, so this a hack because it always goes to the first tab on first launch
        navigationVC.topViewController?.title = "First VC"
    }
    
    private func setupTabBar() {
        self.tabBar.barTintColor = ThemeManager.colorWithKey("UICOLOR_NIGHTMODE_GRAY")
        self.tabBar.translucent = false
        self.tabBar.tintColor = ThemeManager.colorWithKey("UICOLOR_TABBAR_TINT")

        for item in self.tabBar.items! {
            item.title = ""
            
            switch item.tag {
            case 1:
                break
            case 2:
                break
            case 3:
                break
            case 4:
                break
            case 5:
                item.image = UIImage(named: "More_Icon.png")
                break
            default:
                break
            }
            
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
    }
    
    private func selectedNavigationTitle() -> String {
        switch self.selectedIndex {
        case 1:
            return "First VC"
        case 2:
            return "Second VC"
        case 3:
            return "Third VC"
        case 4:
            return "Fourth VC"
        case 5:
            return "More"
        default:
            return ""
        }
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        switch item.tag {
        case 1:
            navigationVC.topViewController?.title = "First VC"
            break
        case 2:
            navigationVC.topViewController?.title = "Second VC"
            break
        case 3:
            navigationVC.topViewController?.title = "Third VC"
            break
        case 4:
            navigationVC.topViewController?.title = "Fourth VC"
            break
        case 5:
            navigationVC.topViewController?.title = "More"
            break
        default:
            navigationVC.topViewController?.title = "Something Else"
            break
        }
    }
    
}
