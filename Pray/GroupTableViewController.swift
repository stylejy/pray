//
//  ViewController.swift
//  Pray
//  Created by 이주영 on 08/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

class GroupTableViewController: LPRTableViewController, AddGroupViewControllerDelegate {
    var groupManagement: GroupManagement!
    
    @IBOutlet var tableViewFromStoryboard: LPRTableView!
    
    required init?(coder aDecoder: NSCoder) {
        //for testing
        //print("Group Management says \(returnNumOfGroups())")
        super.init(coder: aDecoder)
        //***Important!!!*** It is used to link tableView in the storyboard to the tableView variable in LPRTableViewController.
        super.tableView = tableViewFromStoryboard
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return ((indexPath as NSIndexPath).row != 0)
    }

    func addGroupViewControllerDidCancel(_ controller: AddGroupViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    //**Have to understand
    //For adding new group
    func addGroupViewController(_ controller: AddGroupViewController, didFinishAddingValue value: String) {
        
        //newRowIndex must be placed before the adding function to return the proper number for the new row index.
        let newRowIndex = groupManagement.groupList.count
        groupManagement.addGroup(value)
        
        //For testing.
        /*for results in groupManagement.returnGroupList() {
            print(results.returnGroupName())
        }*/
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //For editing a group's name
    func addGroupViewController(_ controller: AddGroupViewController, didFinishEditingValue value: String) {
        //parameter value 는 바뀐 이름을 전송해 주고 groupManagement.returnIndex(value)는 원래 선택 되었던 셀의 index 를 리턴해 준다.
        if let index = groupManagement.returnIndex(value) {
            //Database 상의 바뀐 이름은 바로 적용이 되나, 보여지는 셀에서는 아래와 같이 해줘야 업데이트가 된다.
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = value
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    //This method is used to go to the member list scene or the my prayer list scene by which cell is selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 0 {
            performSegue(withIdentifier: "MyPrayerManagement", sender: nil)
        } else {
            performSegue(withIdentifier: "ShowMemberList", sender: tableView.cellForRow(at: indexPath))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddGroup" {
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! AddGroupViewController
            
            controller.delegate = self
        } else if segue.identifier == "EditGroupName" {
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! AddGroupViewController
            
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.groupToEdit = groupManagement!.groupList[(indexPath as NSIndexPath).row]
            }
        } else if segue.identifier == "ShowMemberList" {
            let controller = segue.destination as! MemberTableViewController
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.parentGroup = groupManagement!.groupList[(indexPath as NSIndexPath).row]
            }
        } else if segue.identifier == "MyPrayerManagement" {
            let controller = segue.destination as! MyPrayerViewController
            
            controller.me = groupManagement.groupList[0].groupMembers[0]
            

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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupManagement.groupList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupList", for: indexPath) as UITableViewCell
        
        //** need to understand
        let label = cell.viewWithTag(1000) as! UILabel
        
        let groupList = groupManagement!.groupList[(indexPath as NSIndexPath).row]
        
        label.text = groupList.groupName
        
        return cell
    }
    
    //Used to move data from a source index to a destination index when moveing a cell.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let source = groupManagement.groupList[(sourceIndexPath as NSIndexPath).row]
        let destination = groupManagement.groupList[(destinationIndexPath as NSIndexPath).row]
        groupManagement.groupList[(sourceIndexPath as NSIndexPath).row] = destination
        groupManagement.groupList[(destinationIndexPath as NSIndexPath).row] = source
    }
    
    
    //Prevents users from deleting 나의 기도제목 group.
    //Delete function doesn't appear on 나의 기도제목 cell.
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if (indexPath as NSIndexPath).row != 0 {
            return UITableViewCellEditingStyle.delete
        } else {
            return UITableViewCellEditingStyle.none
        }
    }
    
    //Group deleting function by swiping over a row.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        groupManagement.removeGroup((indexPath as NSIndexPath).row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
   
}

