//
//  PrayerViewProtocol.swift
//  Pray
//
//  Created by 이주영 on 10/09/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

protocol PrayerViewProtocol {
    var tempIndexPath: IndexPath? { get set }
    var isEditingMode: Bool? { get set }
    
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    
    //Actions
    func addBarButtonAction()
    func doneBarButtonAction()
    func cancelBarButtonAction()
    
    //Change Controllers
    func changeControllerSet(_ switchValue: Bool)
    func leftBarItemController(_ switchValue: Bool)
    func rightBarItemController(_ switchValue: Bool)
    func selectedCellController(_ switchValue: Bool)
    func changeDescriptionTitle(_ switchValue: Bool)
    func changeColour(_ switchValue: Bool)
    
    //View related functions
    func textViewDidBeginEditing(_ textView: UITextView)
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    
    //Resizing and scrolling
    func resizeTableViewWithKeyboard(notification: Notification)
    func resizeTableViewWithoutKeyboard(notification: Notification)
    func scrollToRow(selectedRow indexPath: IndexPath)
    
    
    func alertForRemove(inputIndexPath indexPath: IndexPath)
}
