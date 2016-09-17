//
//  MyPrayerViewController.swift
//  Praying
//  Thanks God for all.
//  Created by 이주영 on 22/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

class MyPrayerViewController: CentralViewController {
    
    //addBarButton should not be weak to be changeable with doneBarButton.
    @IBOutlet var myPrayerAddBarButton: UIBarButtonItem!
    @IBOutlet weak var myPrayerInputTextView: UITextView!
    @IBOutlet weak var myPrayerTableView: LPRTableView!
    //** When the controller is assigned, addBarButtonAction should change.
    //@IBOutlet weak var segmentedControllerForAdding: UISegmentedControl!
    @IBOutlet weak var myPrayerCancelBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.triggeredController = self
        
        super.addBarButton = myPrayerAddBarButton
        super.inputTextView = myPrayerInputTextView
        super.tableView = myPrayerTableView
        super.cancelBarButton = myPrayerCancelBarButton
        
        super.viewDidLoad()
    }
}
