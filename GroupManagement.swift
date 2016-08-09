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
    var groupList = [GroupModel]()
    
    init() {
        loadGroupList()
    }
   
    func addGroup(inputGroupName: String) {
        let newGroup = GroupModel()
        newGroup.giveGroupName(inputGroupName)
        groupList.append(newGroup)
    }
    
    func returnGroupList() -> [GroupModel] {
        return groupList
    }
    
    func returnNumOfGroups() -> Int {
        return groupList.count
    }
    
    func returnNumOfMembers(inputIndex: Int) -> Int {
        return groupList[inputIndex].returnNumOfMembers()
    }
    
    /*func returnMembers(inputIndex: Int) -> [String: String] {
        return groupList[inputIndex].returnGroupMembers()
    }*/
    
    //START - For editing group name
    func returnIndex(inputGroupName: String) -> Int! {
        var count = 0
        for value in groupList {
            if value.returnGroupName() == inputGroupName {
                return count
            } else {
                count = count + 1
            }
        }
        return nil
    }
    //END
    
    /*
    func addMember(inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.giveGroupMemberName(inputMemberName)
    }
    
    
    func addPray(inputPray: String, inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.giveGroupMemberPray(inputMemberName, inputPray: inputPray)
    }
 
    */
    
    func removeGroup(inputIndexPath: Int) {
        groupList.removeAtIndex(inputIndexPath)
    }
    
    
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
        
        //print("save")
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
        
        //print("load")
    }
    //END
    
}