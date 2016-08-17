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
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PrayerViewControllerDelegate?
    
    @IBAction func addBarButtonAction() {
        member.prayers.append(inputTextView.text)
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
        addBarButton.enabled = false
        self.tableView.reloadData()
        delegate?.prayerViewController(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //inputTextView.becomeFirstResponder()
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
      
        cell.prayerListLabel.text = prayerList
        
        return cell
    }
    
    //Prayer deleting function by swiping over a row.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        member.removePrayer(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = member.name
        
        tableView.delegate = self
        tableView.dataSource = self
            
    }
}