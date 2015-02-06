//
//  InterfaceController.swift
//  SharingWithFileCoordinator WatchKit Extension
//
//  Created by Natasha Murashev on 2/4/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet weak private var todoItemsTable: WKInterfaceTable!
    
    var todoItems = [String]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        NSFileCoordinator.addFilePresenter(self)
        
        fetchTodoItems()
    }
    
    // MARK: Populate Table From File Coordinator
    
    private func fetchTodoItems() {
        
        let fileCoordinator = NSFileCoordinator()
        
        if let presentedItemURL = presentedItemURL {
            
            fileCoordinator.coordinateReadingItemAtURL(presentedItemURL, options: nil, error: nil)
                { [unowned self] (newURL) -> Void in
                    
                    if let savedData = NSData(contentsOfURL: newURL) {
                        self.todoItems = NSKeyedUnarchiver.unarchiveObjectWithData(savedData) as [String]
                        self.populateTableWithTodoItems(self.todoItems)
                    }
            }
        }
    }
    
    private func populateTableWithTodoItems(items: [String]) {
        self.todoItemsTable.setNumberOfRows(self.todoItems.count, withRowType: "TodoTableRowController")
        
        for (index, todoItem) in enumerate(self.todoItems) {
            if let row = self.todoItemsTable.rowControllerAtIndex(index) as? TodoTableRowController {
                row.todoItemLabel.setText(todoItem)
            }
            
        }
    }

}

// MARK: NSFilePresenter Protocol

extension InterfaceController: NSFilePresenter {
    
    var presentedItemURL: NSURL? {
        
        let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(
            "group.com.natashatherobot.watchlist")
        
        let fileURL = groupURL?.URLByAppendingPathComponent("todoItems.bin")
        return fileURL
    }
    
    var presentedItemOperationQueue: NSOperationQueue {
        return NSOperationQueue.mainQueue()
    }
    
    func presentedItemDidChange() {
        fetchTodoItems()
    }
}
