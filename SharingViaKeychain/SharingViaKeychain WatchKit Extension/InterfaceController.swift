//
//  InterfaceController.swift
//  SharingViaKeychain WatchKit Extension
//
//  Created by Natasha Murashev on 2/5/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import WatchKit
import SharedDataLayer

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var usernameLabel: WKInterfaceLabel!
    @IBOutlet weak var passwordLabel: WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let keychainItem = KeychainItemWrapper(identifier: "SharingViaKeychain", accessGroup: "W6GNU64U6Q.com.natashatherobot.SharingViaKeychain")
        
        
        let passwordData = keychainItem.objectForKey(kSecValueData) as NSData
        let password = NSString(data: passwordData, encoding: NSUTF8StringEncoding)
        
        let username = keychainItem.objectForKey(kSecAttrAccount) as? String
        
        switch (username, password) {
        case (.Some(let username), .Some(let password)):
            usernameLabel.setText(username)
            passwordLabel.setText(password)
        default:
            return
        }
    }
}

