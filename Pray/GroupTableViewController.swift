//
//  ViewController.swift
//  Pray
//  Version 0.0
//  Created by 이주영, 윤지훈 on 08/07/2016.
//  Copyright © 2016 이주영, 윤지훈. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        //This means that there are 20 rows visible.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupList", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row % 20 == 0 {
            label.text = "Group01"
        }
        else if indexPath.row % 20 == 1 {
            label.text = "Group02"
        }
        else if indexPath.row % 20 == 2 {
            label.text = "Group03"
        }
        else if indexPath.row % 20 == 3 {
            label.text = "Group04"
        }
        else if indexPath.row % 20 == 4 {
            label.text = "Group05"
        }
        else if indexPath.row % 20 == 5 {
            label.text = "Group06"
        }
        else if indexPath.row % 20 == 6 {
            label.text = "Group07"
        }
        else if indexPath.row % 20 == 7 {
            label.text = "Group08"
        }
        else if indexPath.row % 20 == 8 {
            label.text = "Group09"
        }
        else if indexPath.row % 20 == 9 {
            label.text = "Group10"
        }
        else if indexPath.row % 20 == 10 {
            label.text = "Group11"
        }
        else if indexPath.row % 20 == 11 {
            label.text = "Group12"
        }
        else if indexPath.row % 20 == 12 {
            label.text = "Group13"
        }
        else if indexPath.row % 20 == 13 {
            label.text = "Group14"
        }
        else if indexPath.row % 20 == 14 {
            label.text = "Group15"
        }
        else if indexPath.row % 20 == 15 {
            label.text = "Group16"
        }
        else if indexPath.row % 20 == 16 {
            label.text = "Group17"
        }
        else if indexPath.row % 20 == 17 {
            label.text = "Group18"
        }
        else if indexPath.row % 20 == 18 {
            label.text = "Group19"
        }
        else if indexPath.row % 20 == 19 {
            label.text = "Group20"
        }
        
        return cell
    }

}

