//
//  ViewController.swift
//  SharingWithFramework
//
//  Created by Natasha Murashev on 2/5/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import UIKit
import MySharedDataLayer

class ViewController: UIViewController {

    @IBOutlet weak var favoriteThingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myFavoriteThings = MySharedData().myFavoriteThings
        
        let favoriteThingsString = ", ".join(myFavoriteThings)
        favoriteThingsLabel.text = "My favorite things are \(favoriteThingsString)"
    }
}

