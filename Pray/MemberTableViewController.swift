//
//  MainTableViewController.swift
//  Pray
//
//  Created by 이주영 on 05/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

class MemberTableViewController: UITableViewController, AddMemberViewControllerDelegate {
    
    var parentGroup: GroupModel!
    
    func addMemberViewControllerDidCancel(controller: AddMemberViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addMemberViewController(controller: AddMemberViewController, didFinishAddingValue value: String) {
        
        let newRowIndex = parentGroup.returnNumOfMembers()
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        parentGroup.giveGroupMemberName(indexPath.row, inputName: value)

        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addMemberViewController(controller: AddMemberViewController, didFinishEditingValue value: String) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = parentGroup.groupName
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentGroup.groupMembers.count
    }

    //Need to understand...
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellForTableView(tableView)
        
        let memberList = parentGroup.groupMembers[indexPath.row]
        
        cell.textLabel!.text = memberList.name
        
        return cell
    }
    
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "MemberCell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddMember" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let controller = navigationController.topViewController as! AddMemberViewController
            
            controller.delegate = self
        }
    }

}
