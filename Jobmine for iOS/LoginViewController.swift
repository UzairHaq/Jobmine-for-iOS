//
//  ViewController.swift
//  Jobmine for iOS
//
//  Created by Uzair Haq on 2016-02-26.
//  Copyright © 2016 Uzair Haq. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private let userNameTextField = LoginField()
    private let passwordTextField = LoginField()
    private let signinButton = UIButton()
    private let rememberMeView = UIView()
    private let rememberSwitch = UISwitch()
    private let waterlooSiteBtn = UIButton()
    private let jobmineDesktopBtn = UIButton()
    private let bottomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Follow the Weekly AJ")
        setupViews()
        checkRememberState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func checkRememberState() {
        let defaults = NSUserDefaults.standardUserDefaults()
        rememberSwitch.on = defaults.boolForKey("rememberMe")
        userNameTextField.text = defaults.objectForKey("userName") as? String
        passwordTextField.text = defaults.objectForKey("password") as? String
    }
    
    private func setupViews() {
        let logoView = UIImageView(image: UIImage(named: "waterloo_logo"))
        let nameLabel = UILabel()
        
        self.view.addSubview(userNameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signinButton)
        self.view.addSubview(logoView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(jobmineDesktopBtn)
        self.view.addSubview(waterlooSiteBtn)
        
        setupRememberMeView()
        setupBottomView()
        
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont.boldSystemFontOfSize(25.0)
        nameLabel.text = "JOBMINE FOR IOS"
        nameLabel.textAlignment = .Center
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = ThemeManager.sharedManager.colorWithKey("UICOLOR_NIGHTMODE_GRAY")
        
        let attributes = [NSForegroundColorAttributeName : UIColor.grayColor(), NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "User ID", attributes: attributes)
        userNameTextField.font = UIFont.systemFontOfSize(14.0)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        passwordTextField.font = UIFont.systemFontOfSize(14.0)
        passwordTextField.secureTextEntry = true
        
        signinButton.layer.borderWidth = 1.0
        signinButton.setTitle("Login", forState: .Normal)
        signinButton.setTitleColor(ThemeManager.sharedManager.colorWithKey("UICOLOR_NIGHTMODE_GRAY"), forState: .Normal)
        signinButton.titleLabel?.font = UIFont.systemFontOfSize(16.0)
        signinButton.backgroundColor = UIColor.grayColor()
        signinButton.layer.borderColor = UIColor.clearColor().CGColor
        signinButton.addTarget(self, action: "submit", forControlEvents: .TouchUpInside)
        signinButton.addTarget(self, action: "pressedDownColor:", forControlEvents: .TouchDown)
        signinButton.addTarget(self, action: "defaultColor:", forControlEvents: .TouchDragOutside)
        
        let viewsDictionary = ["usernameField": userNameTextField, "passwordField": passwordTextField, "logoView": logoView, "signButton": signinButton, "rememberView": rememberMeView, "nameLabel": nameLabel, "bottomView": bottomView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[usernameField]-30-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[passwordField]-30-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-120-[logoView(80)]-(<=-80)-[nameLabel][usernameField(45)]-(-1)-[passwordField(45)]-15-[rememberView]-15-[signButton(45)]", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomView(55)]-(-1)-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[logoView]-30-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[nameLabel]-30-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[rememberView]-30-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[signButton]-30-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(-1)-[bottomView]-(-1)-|", options: [], metrics: nil, views: viewsDictionary))
        
        let verticalConstraint = NSLayoutConstraint(item: self.view, attribute: .CenterY, relatedBy: .Equal, toItem: userNameTextField, attribute: .CenterY, multiplier: 1.0, constant: 0)
        self.view.addConstraint(verticalConstraint)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissTextField")
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupRememberMeView() {
        rememberMeView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rememberMeView)
        
        let rememberLabel = UILabel()
        rememberLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberLabel.text = "Remember me"
        rememberLabel.textColor = UIColor.lightGrayColor()
        rememberLabel.font = UIFont.systemFontOfSize(14.0)
        
        rememberSwitch.translatesAutoresizingMaskIntoConstraints = false
        rememberSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        
        rememberMeView.addSubview(rememberLabel)
        rememberMeView.addSubview(rememberSwitch)
        
        let viewsDictionary = ["rememberLabel": rememberLabel, "rememberSwitch": rememberSwitch]
        
        rememberMeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[rememberLabel]-[rememberSwitch]|", options: [], metrics: nil, views: viewsDictionary))
        rememberMeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[rememberLabel]|", options: [], metrics: nil, views: viewsDictionary))
        rememberMeView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[rememberSwitch]|", options: [], metrics: nil, views: viewsDictionary))
    }
    
    private func setupBottomView() {
        self.view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.addSubview(jobmineDesktopBtn)
        bottomView.addSubview(waterlooSiteBtn)
        
        jobmineDesktopBtn.translatesAutoresizingMaskIntoConstraints = false
        waterlooSiteBtn.translatesAutoresizingMaskIntoConstraints = false
        
        jobmineDesktopBtn.backgroundColor = UIColor.clearColor()
        jobmineDesktopBtn.layer.borderColor = UIColor.darkGrayColor().CGColor
        jobmineDesktopBtn.layer.borderWidth = 1.0
        jobmineDesktopBtn.setTitle("View in Browser", forState: .Normal)
        jobmineDesktopBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        jobmineDesktopBtn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        waterlooSiteBtn.backgroundColor = UIColor.clearColor()
        waterlooSiteBtn.layer.borderColor = UIColor.darkGrayColor().CGColor
        waterlooSiteBtn.layer.borderWidth = 1.0
        waterlooSiteBtn.setTitle("UWaterloo Website", forState: .Normal)
        waterlooSiteBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        waterlooSiteBtn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        jobmineDesktopBtn.addTarget(self, action: "clickViewInBrowser:", forControlEvents: .TouchUpInside)
        jobmineDesktopBtn.addTarget(self, action: "pressedDownColor:", forControlEvents: .TouchDown)
        jobmineDesktopBtn.addTarget(self, action: "defaultColor:", forControlEvents: .TouchDragOutside)
        
        waterlooSiteBtn.addTarget(self, action: "clickWaterlooSite:", forControlEvents: .TouchUpInside)
        waterlooSiteBtn.addTarget(self, action: "pressedDownColor:", forControlEvents: .TouchDown)
        waterlooSiteBtn.addTarget(self, action: "defaultColor:", forControlEvents: .TouchDragOutside)
        
        let viewsDictionary = ["waterlooSite": waterlooSiteBtn, "jobmineSite": jobmineDesktopBtn]
        
        self.view.addConstraint(NSLayoutConstraint(item: jobmineDesktopBtn, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.5, constant: 1.5))
        self.view.addConstraint(NSLayoutConstraint(item: waterlooSiteBtn, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.5, constant: 1.5))
        
        bottomView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[jobmineSite]-(<=0)-[waterlooSite]|", options: [], metrics: nil, views: viewsDictionary))
        bottomView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[waterlooSite]|", options: [], metrics: nil, views: viewsDictionary))
        bottomView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[jobmineSite]|", options: [], metrics: nil, views: viewsDictionary))
    }
    
    func dismissTextField() {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func pressedDownColor(sender: AnyObject?) {
        let button = sender as! UIButton
        
        switch(button) {
        case signinButton:
            button.backgroundColor = UIColor.lightGrayColor()
            break
        case jobmineDesktopBtn:
            button.backgroundColor = UIColor.grayColor()
            break
        case waterlooSiteBtn:
            button.backgroundColor = UIColor.grayColor()
            break
        default:
            break
        }
        
    }
    
    func defaultColor(sender: AnyObject?) {
        let button = sender as! UIButton
        
        switch(button) {
        case signinButton:
            button.backgroundColor = UIColor.grayColor()
            break
        case jobmineDesktopBtn:
            button.backgroundColor = UIColor.clearColor()
            break
        case waterlooSiteBtn:
            button.backgroundColor = UIColor.clearColor()
            break
        default:
            break
        }
        
    }
    
    func clickViewInBrowser(sender: AnyObject?) {
        let button = sender as! UIButton
        button.backgroundColor = UIColor.clearColor()
        UIApplication.sharedApplication().openURL(NSURL(string: "https://uwaterloo.ca/jobmine/")!)
    }
    
    func clickWaterlooSite(sender: AnyObject?) {
        let button = sender as! UIButton
        button.backgroundColor = UIColor.clearColor()
        UIApplication.sharedApplication().openURL(NSURL(string: "https://uwaterloo.ca")!)
    }
    
    func submit() {
        signinButton.backgroundColor = UIColor.grayColor()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let loginManager = LoginNetworkManager()
        loginManager.loginDelegate = self
        loginManager.setParameters(userNameTextField.text!, password: passwordTextField.text!)
    }
    
}

extension LoginViewController: LoginDelegate {
    func didReceiveCorrectResponse(info: NSString) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "session")
            
            if self.rememberSwitch.on {
                defaults.setBool(true, forKey: "rememberMe")
                defaults.setObject(self.userNameTextField.text, forKey: "userName")
                defaults.setObject(self.passwordTextField.text, forKey: "password")
            } else {
                defaults.setBool(false, forKey: "rememberMe")
                defaults.removeObjectForKey("userName")
                defaults.removeObjectForKey("password")
            }
            
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }
    }
    
    func didReceiveIncorrectResponse(error: String) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            var loginAlert = UIAlertController()
            if error == "106" {
                loginAlert = UIAlertController(title: "Login Failed", message: "Please enter your username/password", preferredStyle: .Alert)
            } else {
                loginAlert = UIAlertController(title: "Login Failed", message: "Please ensure your login credentials are correct.", preferredStyle: .Alert)
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
                loginAlert.dismissViewControllerAnimated(true, completion: nil)
            }
            
            loginAlert.addAction(okAction)
            self.presentViewController(loginAlert, animated: true, completion: { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }

    }
    
    func didFailWithError(error: NSError) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let loginAlert = UIAlertController(title: "Login Failed", message: "There was a network error, please make sure you have a stable network.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
                loginAlert.dismissViewControllerAnimated(true, completion: nil)
            }
            
            loginAlert.addAction(okAction)
            self.presentViewController(loginAlert, animated: true, completion: { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })

        }
    }
}
