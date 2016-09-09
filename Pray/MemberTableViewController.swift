//
//  MainTableViewController.swift
//  Pray
//
//  Created by 이주영 on 05/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit
import Foundation

class MemberTableViewController: UITableViewController, AddMemberViewControllerDelegate, PrayerViewControllerDelegate {
    
    var parentGroup: GroupModel!
    @IBOutlet var tableViewFromStoryboard: LPRTableView!
    
    func addMemberViewControllerDidCancel(_ controller: AddMemberViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addMemberViewController(_ controller: AddMemberViewController, didFinishAddingValue value: String) {
        
        let newRowIndex = parentGroup.groupMembers.count
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        parentGroup.giveGroupMemberName((indexPath as NSIndexPath).row, inputName: value)

        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    func addMemberViewController(_ controller: AddMemberViewController, didFinishEditingValue value: String) {
        if let index = parentGroup.returnIndex(value) {
            //Database 상의 바뀐 이름은 바로 적용이 되나, 보여지는 셀에서는 아래와 같이 해줘야 업데이트가 된다.
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel?.text = value
            }
        }
        dismiss(animated: true, completion: nil)
    }

    //Used to update member view cells every time new prayer is added for the subtitles appearing properly.
    func prayerViewController(_ controller: PrayerViewController) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //***Important!!!*** It is used to link tableView in the storyboard to the tableView variable in LPRTableViewController.
        super.tableView = tableViewFromStoryboard
        title = parentGroup.groupName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //inputTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentGroup.groupMembers.count
    }

    //Need to understand...
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "MemberList")! as UITableViewCell
        
        let member = parentGroup.groupMembers[(indexPath as NSIndexPath).row]
        
        cell!.textLabel?.text = member.name
        
        if member.prayers.count > 0 {
            let index = chooseRandomPrayerForDetailLabel(member)
            //Subtitle setting is done in the storyboard.
            let memberPrayer = member.prayers[index]
            cell!.detailTextLabel?.text = memberPrayer.prayer
        } else {
            cell!.detailTextLabel?.text = "기도 제목을 입력해 주세요"
        }
        
        return cell!
    }
    
    //Used to move data from a source index to a destination index when moveing a cell.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let source = parentGroup.groupMembers[(sourceIndexPath as NSIndexPath).row]
        let destination = parentGroup.groupMembers[(destinationIndexPath as NSIndexPath).row]
        parentGroup.groupMembers[(sourceIndexPath as NSIndexPath).row] = destination
        parentGroup.groupMembers[(destinationIndexPath as NSIndexPath).row] = source
        self.tableView.reloadData()
    }
    
    func chooseRandomPrayerForDetailLabel(_ inputMember: MemberModel) -> Int{
        return Int(arc4random_uniform(UInt32(inputMember.prayers.count)))
    }
    
    func cellForTableView(_ tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "MemberList"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PrayerManagement", sender: tableView.cellForRow(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMember" {
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! AddMemberViewController
            
            controller.delegate = self
        } else if segue.identifier == "EditMemberName" {
            let navigationController = segue.destination as! UINavigationController
            
            let controller = navigationController.topViewController as! AddMemberViewController
            
            controller.delegate = self
                        
            //Initialise memberToEdit variable in AddMemberViewController class.
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.memberToEdit = parentGroup.groupMembers[(indexPath as NSIndexPath).row]
            }
        } else if segue.identifier == "PrayerManagement" {
            let controller = segue.destination as! PrayerViewController
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.member = parentGroup.groupMembers[(indexPath as NSIndexPath).row]
            }
            
            controller.delegate = self
        }
    }
    
    //Activate swipeable editing buttons for cells.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Edit button
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "EditMemberName", sender: tableView.cellForRow(at: indexPath))
        }
        edit.backgroundColor = UIColor(red: 238 / 255, green: 186 / 255, blue: 76 / 255, alpha: 1.0)
        
        //Remove button
        //When button is tapped, an alert popup turns so that the user makes sure.
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { (action, indexPath) in
            let myAlertController: UIAlertController = UIAlertController(title: "", message: "그룹을 삭제 하시겠습니까?", preferredStyle: .alert)
            
            let yesAction: UIAlertAction = UIAlertAction(title: "예", style: .default) { action -> Void in
                //Remove action
                self.parentGroup.removeMember((indexPath as NSIndexPath).row)
                
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
        
        return [remove, edit]
    }


}
