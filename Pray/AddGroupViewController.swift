//
//  AddGroupViewController.swift
//  Pray
//
//  Created by 이주영 on 12/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

class AddGroupViewController: UITableViewController, UITextFieldDelegate {
    
    let groupResults = GroupTableViewController().groupResults
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!

    
    @IBAction func cancelButton() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func doneButton() {
        print("Input group name is: \(textField.text!)")
        groupResults.addGroup(textField.text!)
        print(groupResults.returnNumOfGroups())
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Prevents the text field turning grey.
    //Makes the cell not selectable.
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    
    //The view controller receives the viewWillAppear() message just before it becomes visible. 
    //That is a perfect time to make the text field active. You do this by sending it the becomeFirstResponder() message.
    //Makes the cursor on the textfield automatically.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    //Makes "Done" bar button activated only if the textfield gets characters.
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                                                 replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = (newText.length > 0)
        
        return true
    }
    
}
