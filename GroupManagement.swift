//
//  GroupManagement.swift
//  Pray
//
//  Created by 이주영 on 11/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import Foundation
import UIKit

class GroupManagement {
    //Assign GroupModel type array to groupList variable.
    var groupList = [GroupModel]()
    
    init() {
        //When this class is called, the group list the last time user saved is fetched.
        loadGroupList()
    }
   
    func addGroup(inputGroupName: String) {
        let newGroup = GroupModel()
        newGroup.groupName = inputGroupName
        groupList.append(newGroup)
    }
    
    func removeGroup(inputIndexPath: Int) {
        groupList.removeAtIndex(inputIndexPath)
    }
    
    //START - For editing group name
    func returnIndex(inputGroupName: String) -> Int! {
        var count = 0
        for value in groupList {
            if value.groupName == inputGroupName {
                return count
            } else {
                count = count + 1
            }
        }
        return nil
    }
    //END
    
    //START - For saving and loading data
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("GroupList.plist")
    }
    
    func saveGroupList() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(groupList, forKey: "GroupList")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadGroupList() {
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                groupList = unarchiver.decodeObjectForKey("GroupList") as! [GroupModel]
                unarchiver.finishDecoding()
            }
        }
    }
    //End
}