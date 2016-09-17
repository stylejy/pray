//
//  PrayerTableViewController.swift
//  Praying
//  Thanks God for all.
//  Created by 이주영 on 11/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import UIKit

protocol PrayerViewControllerDelegate: class {
    func prayerViewController(_ controller: PrayerViewController)
}

class PrayerViewController: CentralViewController {

    //addBarButton should not be weak to be changeable with doneBarButton.
    @IBOutlet var prayerAddBarButton: UIBarButtonItem!
    @IBOutlet weak var prayerInputTextView: UITextView!
    @IBOutlet weak var prayerTableView: LPRTableView!
    @IBOutlet weak var prayerCancelBarButton: UIBarButtonItem!
    
    //Not placed in MyPrayerViewController
    weak var delegate: PrayerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.triggeredController = self
        
        super.addBarButton = prayerAddBarButton
        super.inputTextView = prayerInputTextView
        super.tableView = prayerTableView
        super.cancelBarButton = prayerCancelBarButton
        
        title = super.model.name
        
        super.viewDidLoad()
    }
    
//START - Actions
    @IBAction override func addBarButtonAction() {
        super.addBarButtonAction()
        //Used to update member view cells every time new prayer is added for the subtitles appearing properly. (It's not placed in MyPrayerViewController)
        delegate?.prayerViewController(self)
    }
    
    override func doneBarButtonAction() {
        super.doneBarButtonAction()
        //Used to update member view cells every time new prayer is added for the subtitles appearing properly. (It's not placed in MyPrayerViewController)
        delegate?.prayerViewController(self)
    }
//End - Actions
}
