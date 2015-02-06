//
//  ViewController.swift
//  SharingWithUserDefaults
//
//  Created by Natasha Murashev on 2/4/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let defaults = NSUserDefaults(suiteName: "group.com.natashatherobot.userdefaults")
    let key = "userInput"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel.text = defaults?.stringForKey(key) ?? "Type Something..."
    }


    @IBAction func onSaveTap(sender: AnyObject) {
        
        let sharedText = textField.text
        
        textLabel.text = sharedText
        
        defaults?.setObject(sharedText, forKey: key)
        defaults?.synchronize()
    }

}

