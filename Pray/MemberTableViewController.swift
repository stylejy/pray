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
        if let index = parentGroup.returnIndex(value) {
            //Database 상의 바뀐 이름은 바로 적용이 되나, 보여지는 셀에서는 아래와 같이 해줘야 업데이트가 된다.
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = value
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberList", forIndexPath: indexPath)
        
        let memberList = parentGroup.groupMembers[indexPath.row]
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = memberList.name
        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("PrayerManagement", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddMember" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let controller = navigationController.topViewController as! AddMemberViewController
            
            controller.delegate = self
        } else if segue.identifier == "EditMemberName" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let controller = navigationController.topViewController as! AddMemberViewController
            
            controller.delegate = self
                        
            //Initialise memberToEdit variable in AddMemberViewController class.
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.memberToEdit = parentGroup.groupMembers[indexPath.row]
            }
        } else if segue.identifier == "PrayerManagement" {
            let controller = segue.destinationViewController as! PrayerViewController
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.member = parentGroup.groupMembers[indexPath.row]
            }
        }
    }
    
    //Member deleting function by swiping over a row.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        parentGroup.removeMember(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
    }

}
