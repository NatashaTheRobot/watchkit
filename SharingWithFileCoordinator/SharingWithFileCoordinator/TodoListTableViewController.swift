//
//  TodoListTableViewController.swift
//  SharingWithFileCoordinator
//
//  Created by Natasha Murashev on 2/4/15.
//  Copyright (c) 2015 NatashaTheRobot. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {

    var todoItems = [String]()
    var fileCoordinator = NSFileCoordinator()
    
    private let inputCellIdentifier = "inputCell"
    private let todoItemCellIdentifier = "todoItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTodoItems()
    }
    
    // MARK: File Coordinator Operations
    
    private func fetchTodoItems() {
        
        // get the todo items array
        if let presentedItemURL = presentedItemURL {
            fileCoordinator.coordinateReadingItemAtURL(presentedItemURL, options: nil, error: nil)
                { [unowned self] (newURL) -> Void in
                    
                    if let savedData = NSData(contentsOfURL: newURL) {
                        self.todoItems = NSKeyedUnarchiver.unarchiveObjectWithData(savedData) as [String]
                    }
            }
            
        }
    }
    
    private func saveTodoItem(todoItem :String) {
        
        // write item into the todo items array
        if let presentedItemURL = presentedItemURL {
            
            fileCoordinator.coordinateWritingItemAtURL(presentedItemURL, options: nil, error: nil)
                { [unowned self] (newURL) -> Void in
                    
                    self.todoItems.insert(todoItem, atIndex: 0)
                    
                    let dataToSave = NSKeyedArchiver.archivedDataWithRootObject(self.todoItems)
                    let success = dataToSave.writeToURL(newURL, atomically: true)
            }
        }
    }

}

// MARK: NSFilePresenter Protocol

extension TodoListTableViewController: NSFilePresenter {
    
    var presentedItemURL: NSURL? {
        
        let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(
            "group.com.natashatherobot.watchlist")
        
        let fileURL = groupURL?.URLByAppendingPathComponent("todoItems.bin")
        return fileURL
    }
    
    var presentedItemOperationQueue: NSOperationQueue {
        return NSOperationQueue.mainQueue()
    }

}

// MARK: TableView Data Source

extension TodoListTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.row == 0 {
            cell = inputCell
        } else {
            let todoItemCell = tableView.dequeueReusableCellWithIdentifier(todoItemCellIdentifier) as UITableViewCell
            todoItemCell.textLabel?.text = self.todoItems[indexPath.row - 1]
            cell = todoItemCell
        }
        
        return cell ?? UITableViewCell()
    }

}

// MARK: Private Helper Functions

private extension TodoListTableViewController {
    
    var inputCell: InputTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(inputCellIdentifier) as InputTableViewCell
        cell.configure(onDoneHandler: { [unowned self] (inputText) -> Void in
            if let inputText = inputText {
                self.saveTodoItem(inputText)
                self.tableView.reloadData()
            }
        })
        return cell
    }
    
}
