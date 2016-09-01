//
//  PrayerTableViewController.swift
//  Pray
//
//  Created by 이주영 on 11/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

protocol PrayerViewControllerDelegate: class {
    func prayerViewController(controller: PrayerViewController)
}

class PrayerViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var member: MemberModel!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var tableView: LPRTableView!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    weak var delegate: PrayerViewControllerDelegate?
    
    @IBAction func addBarButtonAction() {
        let newPrayer = PrayerModel()
        newPrayer.prayer = inputTextView.text
        newPrayer.date = NSDate()
        member.prayers.append(newPrayer)
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
        addBarButton.enabled = false
        self.tableView.reloadData()
        leftBarItemController(false)
        //Used to update member view cells every time new prayer is added for the subtitles appearing properly.
        delegate?.prayerViewController(self)
    }
    
    //It clears the text view and hide the keyboard
    @IBAction func cancelBarButtonAction() {
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
        leftBarItemController(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //inputTextView.becomeFirstResponder()
    }
    
    //Used to display the cancel bar button and hide the back button when the text view is tapped and the keyboard appears.
    func textViewDidBeginEditing(textView: UITextView) {
        leftBarItemController(true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if textView.restorationIdentifier! == "Input" {
            let oldText: NSString = inputTextView.text!
            let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: text)
            addBarButton.enabled = (newText.length > 0)
            
            //To use 'done' button like 'add' button
            if text == "\n" {
                addBarButtonAction()
            }
        } else {
            
        }
        
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return member.prayers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //as! PrayerTableViewCellController is used to have access to the controller's outlets
        let cell = tableView.dequeueReusableCellWithIdentifier("PrayerList", forIndexPath: indexPath) as! PrayerTableViewCellController
        let prayerList = member.prayers[indexPath.row]
        
        cell.prayerListLabel.numberOfLines = 0
        cell.prayerListLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
      
        cell.prayerListLabel.text = prayerList.prayer
        
        //START - To form date in String type
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd.MMM.yyyy"
        let dateString = formatter.stringFromDate(prayerList.date)
        cell.prayerDetails.text = dateString
        //End
        
        return cell
    }
    
    //Used to move data from a source index to a destination index when moveing a cell.
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let source = member.prayers[sourceIndexPath.row]
        let destination = member.prayers[destinationIndexPath.row]
        member.prayers[sourceIndexPath.row] = destination
        member.prayers[destinationIndexPath.row] = source
    }
    
    //Prayer deleting function by swiping over a row.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        member.removePrayer(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
    }
    
    //Used to initially hide Cancel bar button to have only back button in the right position.
    //false : hide the cancel bar button and the back button appears
    func leftBarItemController(selector: Bool) {
        if selector == false {
            self.navigationItem.leftItemsSupplementBackButton = true
            cancelBarButton.title = ""
        } else {
            self.navigationItem.leftItemsSupplementBackButton = false
            cancelBarButton.title = "Cancel"
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = member.name
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        leftBarItemController(false)
    }
}