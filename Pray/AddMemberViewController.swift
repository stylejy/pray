//
//  AddMemberViewController.swift
//  Pray
//
//  Created by 이주영 on 06/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

protocol AddMemberViewControllerDelegate: class {
    func addMemberViewControllerDidCancel(controller: AddMemberViewController)
    func addMemberViewController(controller: AddMemberViewController, didFinishAddingValue value: String)
    func addMemberViewController(controller: AddMemberViewController, didFinishEditingValue value: String)
}

class AddMemberViewController: UITableViewController, UITextFieldDelegate {
    var groupToEdit: GroupModel?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: AddMemberViewControllerDelegate?
    
    @IBAction func cancelBarButton() {
        delegate?.addMemberViewControllerDidCancel(self)
    }
    
    @IBAction func doneButton() {
        delegate?.addMemberViewController(self, didFinishAddingValue: textField.text!)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let group = groupToEdit {
            title = "멤버 이름 변경"
            textField.text = group.returnGroupName()
            doneBarButton.enabled = true
        }
    }

    
}
