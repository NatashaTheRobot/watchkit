//
//  InterfaceController.swift
//  SharingWithUserDefaults WatchKit Extension
//
//  Created by Natasha Murashev on 2/4/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import WatchKit

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var textLabel: WKInterfaceLabel!
    
    let defaults = NSUserDefaults(suiteName:
        "group.com.natashatherobot.userdefaults")
    
    var userInput: String? {
        defaults?.synchronize()
        return defaults?.stringForKey("userInput")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        textLabel.setText(userInput)
    }
    
    // MARK: IBActions

    @IBAction func onUpdateTap() {
        textLabel.setText(userInput)
    }
    
}


