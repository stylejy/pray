//
//  ViewController.swift
//  Pray
//  Created by 이주영, 윤지훈 on 08/07/2016.
//  Copyright © 2016 이주영, 윤지훈. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController, AddGroupViewControllerDelegate {
  
    let groupResults = GroupManagement()

    func addGroupViewControllerDidCancel(controller: AddGroupViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //**Have to understand
    //For adding new group
    func addGroupViewController(controller: AddGroupViewController, didFinishAddingValue value: String) {
        
        //newRowIndex must be placed before the adding function to return the proper number for the new row index.
        let newRowIndex = groupResults.returnNumOfGroups()
        groupResults.addGroup(value)
        
        //For testing.
        /*for results in groupResults.returnGroupList() {
            print(results.returnGroupName())
        }*/
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //For editing a group's name
    func addGroupViewController(controller: AddGroupViewController, didFinishEditingValue value: String) {
        //parameter value 는 바뀐 이름을 전송해 주고 groupResults.returnIndex(value)는 원래 선택 되었던 셀의 index 를 리턴해 준다.
        if let index = groupResults.returnIndex(value) {
            //Database 상의 바뀐 이름은 바로 적용이 되나, 보여지는 셀에서는 아래와 같이 해줘야 업데이트가 된다.
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = value
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddGroup" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let controller = navigationController.topViewController as! AddGroupViewController
            
            controller.delegate = self
        } else if segue.identifier == "EditGroupName" {
            let navigationController = segue.destinationViewController as! UINavigationController
            
            let controller = navigationController.topViewController as! AddGroupViewController
            
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.groupToEdit = groupResults.returnGroupList()[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Returns the number of the groups added.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupResults.returnNumOfGroups()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupList", forIndexPath: indexPath)
        
        //** need to understand
        let label = cell.viewWithTag(1000) as! UILabel
        
        let numOfGroups = groupResults.returnNumOfGroups()
        
        var tableStartingNumber = 0
        for value in groupResults.returnGroupList() {
            if indexPath.row % numOfGroups == tableStartingNumber {
                label.text = value.returnGroupName()
            }
            tableStartingNumber = tableStartingNumber + 1
        }
        
        return cell
    }
    
    //Group deleting function by swiping over a row.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        groupResults.removeGroup(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }

}

