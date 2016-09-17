//
//  ViewController.swift
//  Pray
//  Thanks God for all.
//  Created by 이주영 on 08/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

class GroupTableViewController: LPRTableViewController, AddGroupViewControllerDelegate {
    var groupResults: GroupManagement!
    
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
        let newRowIndex = groupResults.groupList.count
        groupResults.addGroup(value)
        
        //For testing.
        /*for results in groupResults.returnGroupList() {
            print(results.returnGroupName())
        }*/
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //For editing a group's name
    func addGroupViewController(_ controller: AddGroupViewController, didFinishEditingValue value: String) {
        //parameter value 는 바뀐 이름을 전송해 주고 groupResults.returnIndex(value)는 원래 선택 되었던 셀의 index 를 리턴해 준다.
        if let index = groupResults.returnIndex(value) {
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
            let colour = ColourSupporter()
            let controller = navigationController.topViewController as! AddGroupViewController
            
            controller.delegate = self
            //Change colour to colour scheme's yellow.
            controller.navigationController?.navigationBar.barTintColor = colour.yellow
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.groupToEdit = groupResults!.groupList[(indexPath as NSIndexPath).row]
            }
        } else if segue.identifier == "ShowMemberList" {
            let controller = segue.destination as! MemberTableViewController
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.parentGroup = groupResults!.groupList[(indexPath as NSIndexPath).row]
            }
        } else if segue.identifier == "MyPrayerManagement" {
            let controller = segue.destination as! MyPrayerViewController
            
            controller.model = groupResults.groupList[0].groupMembers[0]
            

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
        return groupResults.groupList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupList", for: indexPath) as UITableViewCell
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row == 0 {
            //cell.backgroundColor = UIColor(red: 169 / 255, green: 221 / 255, blue: 217 / 255, alpha: 1.0)
            label.textColor = UIColor(red: 35 / 255, green: 181 / 255, blue: 175 / 255, alpha: 1.0)
        }
        
        let groupList = groupResults!.groupList[(indexPath as NSIndexPath).row]
        
        label.text = groupList.groupName
        
        return cell
    }
    
    //Used to move data from a source index to a destination index when moveing a cell.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let source = groupResults.groupList[(sourceIndexPath as NSIndexPath).row]
        let destination = groupResults.groupList[(destinationIndexPath as NSIndexPath).row]
        groupResults.groupList[(sourceIndexPath as NSIndexPath).row] = destination
        groupResults.groupList[(destinationIndexPath as NSIndexPath).row] = source
    }
    
    //Activate swipeable editing buttons for cells.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Edit button
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "EditGroupName", sender: tableView.cellForRow(at: indexPath))
            self.tableView.setEditing(false, animated: true)
        }
        edit.backgroundColor = UIColor(red: 238 / 255, green: 186 / 255, blue: 76 / 255, alpha: 1.0)
        
        //Remove button
        //When button is tapped, an alert popup turns so that the user makes sure.
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { (action, indexPath) in
            let myAlertController: UIAlertController = UIAlertController(title: "", message: "그룹을 삭제 하시겠습니까?", preferredStyle: .alert)
            
            let yesAction: UIAlertAction = UIAlertAction(title: "예", style: .default) { action -> Void in
                //Remove action
                self.groupResults.removeGroup((indexPath as NSIndexPath).row)
                
                let indexPaths = [indexPath]
                tableView.deleteRows(at: indexPaths, with: .automatic)
            }
            myAlertController.addAction(yesAction)
            
            let noAction: UIAlertAction = UIAlertAction(title: "아니요", style: .default) { action -> Void in
                //Do some stuff
            }
            myAlertController.addAction(noAction)
            
            self.present(myAlertController, animated: true, completion: nil)
            
        }
        remove.backgroundColor = UIColor(red: 227 / 255, green: 73 / 255, blue: 59 / 255, alpha: 1.0)
        
        if indexPath.row != 0 {
            return [remove, edit]
        } else {
            return [edit]
        }
    }
}

