//
//  LoginField.swift
//  Jobmine for iOS
//
//  Created by Uzair Haq on 2016-03-06.
//  Copyright © 2016 Uzair Haq. All rights reserved.
//

import UIKit

class LoginField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setViews() {
        let attributes = [NSForegroundColorAttributeName : UIColor.darkGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
        
        self.attributedPlaceholder = NSAttributedString(string: "", attributes: attributes)
        self.contentVerticalAlignment = .Center
        self.layer.sublayerTransform = CATransform3DMakeTranslation(7, 0, 0)
        self.textColor = UIColor.whiteColor()
        self.attributedText = NSAttributedString(string: "", attributes: attributes)
        self.autocapitalizationType = .None
        
        self.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.layer.borderWidth = 1.0
        
    }
    
    func setPlaceHolderText(text: String?) {
        if let text = text {
            self.placeholder = text
        }
    }
    
}
