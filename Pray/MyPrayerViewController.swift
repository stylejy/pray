//
//  MyPrayerViewController.swift
//  Pray
//
//  Created by 이주영 on 22/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

protocol MyPrayerViewControllerDelegate: class {
    func myPrayerViewController(_ controller: MyPrayerViewController)
}

class MyPrayerViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var me: MemberModel!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var tableView: LPRTableView!
    @IBOutlet weak var segmentedControllerForAdding: UISegmentedControl!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
 
    
    @IBAction func addBarButtonAction() {
        let newPrayer = PrayerModel()
        newPrayer.prayer = inputTextView.text
        if segmentedControllerForAdding.selectedSegmentIndex == 0 {
            newPrayer.isOpen = true
        }
        me.prayers.append(newPrayer)
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
        addBarButton.isEnabled = false
        self.tableView.reloadData()
        leftBarItemController(false)
        //delegate?.myPrayerViewController(self)
    }
    
    //It clears the text view and hide the keyboard
    @IBAction func cancelBarButtonAction() {
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
        leftBarItemController(false)
    }
    
    //Used to display the cancel bar button and hide the back button when the text view is tapped and the keyboard appears.
    func textViewDidBeginEditing(_ textView: UITextView) {
        leftBarItemController(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.restorationIdentifier! == "InputForMe" {
            let oldText: NSString = inputTextView.text! as NSString
            let newText: NSString = oldText.replacingCharacters(in: range, with: text) as NSString
            addBarButton.isEnabled = (newText.length > 0)
            
            //To use 'done' button like 'add' button
            if text == "\n" {
                addBarButtonAction()
            }
        } else {
            
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return me.prayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as! PrayerTableViewCellController is used to have access to the controller's outlets
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPrayerList", for: indexPath) as! MyPrayerTableViewCellController
        let prayerList = me.prayers[(indexPath as NSIndexPath).row]
        
        cell.myPrayerListLabel.numberOfLines = 0
        cell.myPrayerListLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        cell.myPrayerListLabel.text = prayerList.prayer
        
        //START - To form date in String type
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MMM.yyyy"
        let dateString = formatter.string(from: prayerList.date as Date)
        cell.prayerDetails.text = dateString
        //End
        
        if prayerList.isOpen == true {
            
        }
        
        return cell
    }
    
    //Used to move data from a source index to a destination index when moveing a cell.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let source = me.prayers[(sourceIndexPath as NSIndexPath).row]
        let destination = me.prayers[(destinationIndexPath as NSIndexPath).row]
        me.prayers[(sourceIndexPath as NSIndexPath).row] = destination
        me.prayers[(destinationIndexPath as NSIndexPath).row] = source
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        leftBarItemController(false)
    }
    
    //Used to initially hide Cancel bar button to have only back button in the right position.
    //false : hide the cancel bar button and the back button appears
    func leftBarItemController(_ selector: Bool) {
        if selector == false {
            self.navigationItem.leftItemsSupplementBackButton = true
            cancelBarButton.title = ""
        } else {
            self.navigationItem.leftItemsSupplementBackButton = false
            cancelBarButton.title = "Cancel"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //inputTextView.becomeFirstResponder()
    }
    
    //Activate swipeable editing buttons for cells.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Edit button
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            
        }
        edit.backgroundColor = UIColor(red: 238 / 255, green: 186 / 255, blue: 76 / 255, alpha: 1.0)
        
        //Remove button
        //When button is tapped, an alert popup turns so that the user makes sure.
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { (action, indexPath) in
            let myAlertController: UIAlertController = UIAlertController(title: "", message: "기도제목을 삭제 하시겠습니까?", preferredStyle: .alert)
            
            let yesAction: UIAlertAction = UIAlertAction(title: "예", style: .default) { action -> Void in
                //Remove action
                self.me.removePrayer((indexPath as NSIndexPath).row)
                
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
