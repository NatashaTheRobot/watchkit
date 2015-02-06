//
//  ViewController.swift
//  SharingViaKeychain
//
//  Created by Natasha Murashev on 2/5/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import UIKit
import SharedDataLayer

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSaveTap(sender: AnyObject) {
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        let keychainItem = KeychainItemWrapper(identifier: "SharingViaKeychain", accessGroup: "W6GNU64U6Q.com.natashatherobot.SharingViaKeychain")
        
        keychainItem.setObject(username, forKey: kSecAttrAccount)
        keychainItem.setObject(password, forKey: kSecValueData)
        
        usernameTextField.text = nil
        passwordTextField.text = nil
    }

}

