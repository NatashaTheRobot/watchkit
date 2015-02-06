//
//  InputTableViewCell.swift
//  SharingWithFileCoordinator
//
//  Created by Natasha Murashev on 2/4/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak private var taskTextField: UITextField!
    
    typealias onDoneHandlerType = (String?) -> Void
    private var onDoneHandler: onDoneHandlerType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskTextField.delegate = self
    }
    
    func configure(#onDoneHandler: onDoneHandlerType?) {
        self.onDoneHandler = onDoneHandler
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let onDoneHandler = onDoneHandler {
            onDoneHandler(textField.text)
            textField.text = nil
        }
        
        return true
    }
    
}
