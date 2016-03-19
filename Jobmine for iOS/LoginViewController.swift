//
//  ViewController.swift
//  Jobmine for iOS
//
//  Created by Uzair Haq on 2016-02-26.
//  Copyright © 2016 Uzair Haq. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class LoginViewController: UIViewController {
    private let userNameTextField = LoginField()
    private let passwordTextField = LoginField()
    private let signinButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViews() {
        let logoView = UIImageView(image: UIImage(named: "waterloo_logo"))
        
        self.view.addSubview(userNameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signinButton)
        self.view.addSubview(logoView)
        
        setupRememberMeView()
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = UIColor(netHex: 0x15181e)
        
        let attributes = [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "User ID", attributes: attributes)
        userNameTextField.font = UIFont.systemFontOfSize(14.0)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        passwordTextField.font = UIFont.systemFontOfSize(14.0)
        passwordTextField.secureTextEntry = true
        
        signinButton.layer.borderWidth = 1.0
        signinButton.setTitle("Login", forState: .Normal)
        signinButton.setTitleColor(UIColor(netHex: 0x15181e), forState: .Normal)
        signinButton.backgroundColor = UIColor.grayColor()
        signinButton.layer.borderColor = UIColor.clearColor().CGColor
        signinButton.addTarget(self, action: "submit", forControlEvents: .TouchUpInside)
        
        let viewsDictionary = ["usernameField": userNameTextField, "passwordField": passwordTextField, "logoView": logoView, "signButton": signinButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[usernameField]-40-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[passwordField]-40-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-120-[logoView(80)][usernameField(45)]-(-1)-[passwordField(45)]-30-[signButton(45)]", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[logoView]-40-|", options: [], metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[signButton]-40-|", options: [], metrics: nil, views: viewsDictionary))
        
        let verticalConstraint = NSLayoutConstraint(item: self.view, attribute: .CenterY, relatedBy: .Equal, toItem: userNameTextField, attribute: .CenterY, multiplier: 1.0, constant: 0)
        self.view.addConstraint(verticalConstraint)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissTextField")
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupRememberMeView() {
        let rememberMeView = UIView()
        rememberMeView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rememberMeView)
        
    }
    
    func dismissTextField() {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func submit() {
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
            defaults.synchronize()
            self.dismissViewControllerAnimated(true, completion: nil)
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
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }

    }
    
    func didFailWithError(error: NSError) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let loginAlert = UIAlertController(title: "Login Failed", message: "There was a network error, please make sure you have a stable network.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
                loginAlert.dismissViewControllerAnimated(true, completion: nil)
            }
            
            loginAlert.addAction(okAction)
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
    }
}