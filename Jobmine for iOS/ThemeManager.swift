//
//  ThemeManager.swift
//  Jobmine for iOS
//
//  Created by Uzair Haq on 2016-03-20.
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

class ThemeManager: NSObject {
    private static let themesPath = NSBundle.mainBundle().pathForResource("themes", ofType: "plist")
    private static var themesDict = NSDictionary()
    
    override init() {
        super.init()
    }
    
    class func colorWithKey(key: String) -> UIColor {
        themesDict = NSDictionary(contentsOfFile: themesPath!)!
        var colorNum = UInt32()
        
        if let colorValue = themesDict[key] {
            colorNum = convertHexStringToInt(colorValue)
        }
        
        return UIColor(netHex: Int(colorNum))
    }
    
    private class func convertHexStringToInt(colorValue: AnyObject) -> UInt32 {
        let colorString = colorValue as! String
        let colorNum = UInt32(strtoul(colorString, nil, 16))
        return colorNum
    }
}
