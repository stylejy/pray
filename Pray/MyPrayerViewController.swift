//
//  MyPrayerViewController.swift
//  Praying
//  Thanks God for all.
//  Created by 이주영 on 22/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

protocol MyPrayerViewControllerDelegate: class {
    func myPrayerViewController(_ controller: MyPrayerViewController)
}

class MyPrayerViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, PrayerViewProtocol {
    var me: MemberModel!
    var tempIndexPath: IndexPath?
    var isEditingMode: Bool? = false
    
    let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(MyPrayerViewController.doneBarButtonAction))
    //addBarButton should not be weak to be changeable with doneBarButton.
    @IBOutlet var addBarButton: UIBarButtonItem!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var tableView: LPRTableView!
    //** When the controller is assigned, addBarButtonAction should change.
    //@IBOutlet weak var segmentedControllerForAdding: UISegmentedControl!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        leftBarItemController(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(MyPrayerViewController.resizeTableViewWithKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MyPrayerViewController.resizeTableViewWithoutKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
 
//START - Actions
    @IBAction func addBarButtonAction() {
        let newPrayer = PrayerModel()
        newPrayer.prayer = inputTextView.text
        newPrayer.isOpen = true
        
        //** The lines below are only used with the segmentedController
        /*if segmentedControllerForAdding.selectedSegmentIndex == 0 {
            newPrayer.isOpen = true
        }*/
        newPrayer.isOpen = true
        
        me.prayers.append(newPrayer)
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
        addBarButton.isEnabled = false
        self.tableView.reloadData()
        leftBarItemController(false)
    }
    
    func doneBarButtonAction() {
        self.me.prayers[tempIndexPath!.row].prayer = inputTextView.text
        self.me.prayers[tempIndexPath!.row].date = Date()
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
        self.tableView.reloadData()
        
        changeControllerSet(false)
    }
    
    //It clears the text view and hide the keyboard
    @IBAction func cancelBarButtonAction() {
        inputTextView.text = ""
        inputTextView.resignFirstResponder()
        changeControllerSet(false)
    }
//END - Actions
    
//START - Change Controllers
    func changeControllerSet(_ switchValue: Bool) {
        leftBarItemController(switchValue)
        //The next lines are only needed with doneBarButton.
        if self.navigationItem.rightBarButtonItem == doneBarButton || switchValue == true {
            rightBarItemController(switchValue)
            selectedCellController(switchValue)
            changeDescriptionTitle(switchValue)
            changeColour(switchValue)
        }
        
        //When editing mode, long press reorder function is unenabled to not make any problems.
        if switchValue == true {
            tableView.longPressReorderEnabled = false
            isEditingMode = true
        } else {
            tableView.longPressReorderEnabled = true
            isEditingMode = false
        }
    }
    
    //Used to initially hide Cancel bar button to have only back button in the right position.
    //false : hide the cancel bar button and the back button appears
    func leftBarItemController(_ switchValue: Bool) {
        if switchValue == false {
            self.navigationItem.leftItemsSupplementBackButton = true
            cancelBarButton.title = ""
        } else {
            self.navigationItem.leftItemsSupplementBackButton = false
            cancelBarButton.title = "Cancel"
        }
    }
    
    //If true, doneBarButton appears, otherwise, addBarButton comes.
    func rightBarItemController(_ switchValue: Bool) {
        if switchValue == false {
            if self.navigationItem.rightBarButtonItem != self.addBarButton {
                self.navigationItem.setRightBarButton(self.addBarButton, animated: true)
                self.addBarButton.isEnabled = false
            }
        } else {
            self.navigationItem.setRightBarButton(self.doneBarButton, animated: true)
        }
    }
    
    func selectedCellController(_ switchValue: Bool) {
        if switchValue == true {
            //** Makes a cell sliding in
            tableView.setEditing(false, animated: true)
        }
    }
    
    //For the description label just above the textView.
    func changeDescriptionTitle(_ switchValue: Bool) {
        let label = view.viewWithTag(1000) as! UILabel
        if switchValue == true {
            label.text = "기도 제목 수정:"
        } else {
            label.text = "새로운 기도제목:"
        }
    }
    
    func changeColour(_ switchValue: Bool) {
        let colour = ColourSupporter()
        let cell = self.tableView.cellForRow(at: tempIndexPath!) as! MyPrayerTableViewCellController
        
        if switchValue == true {
            self.navigationController?.navigationBar.barTintColor = colour.yellow
            self.view.backgroundColor = colour.yellow
            
            cell.backgroundColor = colour.red
            cell.myPrayerListLabel.textColor = colour.white
            cell.prayerDetails.textColor = colour.white
        } else {
            self.navigationController?.navigationBar.barTintColor = colour.aqua
            self.view.backgroundColor = colour.aqua
            
            cell.backgroundColor = colour.white
            cell.myPrayerListLabel.textColor = colour.black
            cell.prayerDetails.textColor = colour.black
        }
    }
//END - Change Controllers

//START - View related functions called by super class or delegates
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
            //Different functions will be called by which button is tapped.
            if text == "\n" && self.navigationItem.rightBarButtonItem == addBarButton {
                addBarButtonAction()
            }
            else if text == "\n" && self.navigationItem.rightBarButtonItem == doneBarButton {
                //For editing.
                //doneBarButtonAction includes controller functions
                doneBarButtonAction()
            }
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
    
    //Activate swipeable editing buttons for cells.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Edit button
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.inputTextView.text = self.me.prayers[indexPath.row].prayer
            self.inputTextView.becomeFirstResponder()
            
            //This if statement is used to put the previous selected cell's settings back.
            if self.navigationItem.rightBarButtonItem == self.doneBarButton {
                self.changeColour(false)
                self.selectedCellController(false)
            }
            
            //This is used for doneBarButtonAction function.
            self.tempIndexPath = indexPath
            
            self.changeControllerSet(true)
            
            self.scrollToRow(selectedRow: indexPath)
        }
        edit.backgroundColor = UIColor(red: 238 / 255, green: 186 / 255, blue: 76 / 255, alpha: 1.0)
        
        //Remove button
        //When button is tapped, an alert popup turns so that the user makes sure.
        let remove = UITableViewRowAction(style: .normal, title: "Remove") { (action, indexPath) in
            self.alertForRemove(inputIndexPath: indexPath)
        }
        remove.backgroundColor = UIColor(red: 227 / 255, green: 73 / 255, blue: 59 / 255, alpha: 1.0)
        
        //When editing mode, only edit button appears, otherwise the all buttons come.
        if isEditingMode == false {
            return [remove, edit]
        } else {
            return [edit]
        }
    }
//END - View related functions called by super class or delegates
    
//START - TableView resize and scrolling to the selected row(in editing mode only) when keyboard appears
    func resizeTableViewWithKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                //Offset to show all cells are visible above the keyboard.
                tableView.contentInset.bottom = keyboardSize.size.height
            }
        }
    }
    
    func resizeTableViewWithoutKeyboard(notification: Notification) {
        tableView.contentInset.bottom = UIEdgeInsets.zero.bottom
    }
    
    func scrollToRow(selectedRow indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
    }
//END - TableView resize and scrolling to the selected row(in editing mode only) when keyboard appears
    
    func alertForRemove(inputIndexPath indexPath: IndexPath) {
        let myAlertController: UIAlertController = UIAlertController(title: "", message: "기도제목을 삭제 하시겠습니까?", preferredStyle: .alert)
        
        let yesAction: UIAlertAction = UIAlertAction(title: "예", style: .default) { action -> Void in
            //Remove action
            self.me.removePrayer((indexPath as NSIndexPath).row)
            
            let indexPaths = [indexPath]
            self.tableView.deleteRows(at: indexPaths, with: .automatic)
        }
        myAlertController.addAction(yesAction)
        
        let noAction: UIAlertAction = UIAlertAction(title: "아니요", style: .default) { action -> Void in
            
        }
        myAlertController.addAction(noAction)
        
        self.present(myAlertController, animated: true, completion: nil)
    }
    
}
