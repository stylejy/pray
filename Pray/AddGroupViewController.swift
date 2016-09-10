//
//  AddGroupViewController.swift
//  Praying
//  Thanks God for all.
//  Created by 이주영 on 12/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

protocol AddGroupViewControllerDelegate: class {
    func addGroupViewControllerDidCancel(_ controller: AddGroupViewController)
    func addGroupViewController(_ controller: AddGroupViewController, didFinishAddingValue value: String)
    func addGroupViewController(_ controller: AddGroupViewController, didFinishEditingValue value: String)
}

class AddGroupViewController: UITableViewController, UITextFieldDelegate {
    
    var groupToEdit: GroupModel?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddGroupViewControllerDelegate?

    
    @IBAction func cancelButton() {
        delegate?.addGroupViewControllerDidCancel(self)
    }
    
    
    @IBAction func doneButton() {
        if let group = groupToEdit {
            group.groupName = textField.text!
            delegate?.addGroupViewController(self, didFinishEditingValue: textField.text!)
        } else {
            delegate?.addGroupViewController(self, didFinishAddingValue: textField.text!)
        }
    }
    
    //Prevents the text field turning grey.
    //Makes the cell not selectable.
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    
    //The view controller receives the viewWillAppear() message just before it becomes visible. 
    //That is a perfect time to make the text field active. You do this by sending it the becomeFirstResponder() message.
    //Makes the cursor on the textfield automatically.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    //Makes "Done" bar button activated only if the textfield gets characters.
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                                                 replacementString string: String) -> Bool {
        let oldText: NSString = textField.text! as NSString
        let newText: NSString = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled = (newText.length > 0)
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let group = groupToEdit {
            title = "그룹 이름 수정"
            textField.text = group.groupName
            doneBarButton.isEnabled = true
        }
    }
}
