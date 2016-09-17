//
//  AddMemberViewController.swift
//  Praying
//  Thanks God for all.
//  Created by 이주영 on 06/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

protocol AddMemberViewControllerDelegate: class {
    func addMemberViewControllerDidCancel(_ controller: AddMemberViewController)
    func addMemberViewController(_ controller: AddMemberViewController, didFinishAddingValue value: String)
    func addMemberViewController(_ controller: AddMemberViewController, didFinishEditingValue value: String)
}

class AddMemberViewController: UITableViewController, UITextFieldDelegate {
    var memberToEdit: MemberModel?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: AddMemberViewControllerDelegate?
    
    @IBAction func cancelBarButton() {
        delegate?.addMemberViewControllerDidCancel(self)
    }
    
    @IBAction func doneButton() {
        if memberToEdit != nil {
            //replace the original value with the new one.
            memberToEdit?.name = textField.text!
            //notify the cell to update.
            delegate?.addMemberViewController(self, didFinishEditingValue: textField.text!)
        } else {
            delegate?.addMemberViewController(self, didFinishAddingValue: textField.text!)
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
  
      
        if let group = memberToEdit {
            title = "멤버 이름 변경"
            textField.text = group.name
            doneBarButton.isEnabled = true
        }
    }

    
}
