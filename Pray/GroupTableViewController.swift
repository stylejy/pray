//
//  ViewController.swift
//  Pray
//  Version 0.0
//  Created by 이주영, 윤지훈 on 08/07/2016.
//  Copyright © 2016 이주영, 윤지훈. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
    let groupResults = GroupManagement()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Returns the number of the groups added.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupResults.returnNumOfGroups()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupList", forIndexPath: indexPath)
        
        //** need to understand
        let label = cell.viewWithTag(1000) as! UILabel
        
        let numOfGroups = groupResults.returnNumOfGroups()
        
        var tableStartingNumber = 0
        for value in groupResults.returnGroupList() {
            if indexPath.row % numOfGroups == tableStartingNumber {
                label.text = value.returnGroupName()
            }
            tableStartingNumber = tableStartingNumber + 1
        }
        
        return cell
    }

}

