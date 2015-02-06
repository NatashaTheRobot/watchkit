//
//  InterfaceController.swift
//  SharingWithFramework WatchKit Extension
//
//  Created by Natasha Murashev on 2/5/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import WatchKit
import MySharedDataLayer

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var favoriteThingsLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let myFavoriteThings = MySharedData().myFavoriteThings
        
        let favoriteThingsString = ", ".join(myFavoriteThings)
        favoriteThingsLabel.setText("My favorite things are \(favoriteThingsString)")
    }

}


