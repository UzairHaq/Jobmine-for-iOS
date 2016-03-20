//
//  LoginNetworkManager.swift
//  Jobmine for iOS
//
//  Created by Uzair Haq on 2016-02-26.
//  Copyright © 2016 Uzair Haq. All rights reserved.
//

import UIKit


protocol LoginDelegate {
    func didReceiveCorrectResponse(info: NSString)
    func didReceiveIncorrectResponse(error: String)
    func didFailWithError(error: NSError)
}

class LoginNetworkManager: NSObject {
    
    let URL_LOGIN_STRING = "https://jobmine.ccol.uwaterloo.ca/psp/SS/?cmd=login&languageCd=ENG&sessionId="
    var LOGIN_POST_STRING = String()
    private let param = LoginViewController()
    
    private var username = String()
    private var password = String()
    
    var loginDelegate: LoginDelegate?
    
    override init() {
        super.init()
        
    }
    
    private func getLoginHTML() {
        let url = NSURL(string: URL_LOGIN_STRING)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = LOGIN_POST_STRING.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let error = error {
                self.loginDelegate?.didFailWithError(error)
                return
            } else {
                let httpResponse = response as? NSHTTPURLResponse
                if let response = httpResponse, url = response.URL {
                    let urlString = "\(url)"
                    let missingFieldError = "errorCode=106"
                    
                    if urlString.rangeOfString(missingFieldError) != nil {
                        self.loginDelegate?.didReceiveIncorrectResponse("106")
                    } else if urlString.rangeOfString("errorCode=") != nil {
                        self.loginDelegate?.didReceiveIncorrectResponse("")
                    } else {
                        self.loginDelegate?.didReceiveCorrectResponse(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func setParameters(username: String, password: String) {
        self.username = username
        self.password = password
        
        LOGIN_POST_STRING = "httpPort=&timezoneOffset=300&userid=\(username)&pwd=\(password)&submit=Submit"
        getLoginHTML()
    }
    
}
