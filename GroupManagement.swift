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
        setUpMyPrayerGroup()
    }
   
    func setUpMyPrayerGroup() {
        let name = "\u{1F64F} 나의 기도제목"
        if groupList.count == 0 || groupList[0].groupName != name {
            groupList.insert(createNewGroupModel(name), at: 0)
            let meMemberModel = MemberModel()
            //There is only one member in my prayer group.
            groupList[0].groupMembers.append(meMemberModel)
        }
    }
    
    func createNewGroupModel(_ inputName: String) -> GroupModel {
        let newGroup = GroupModel()
        newGroup.groupName = inputName
        return newGroup
    }
    
    func addGroup(_ inputGroupName: String) {
        groupList.append(createNewGroupModel(inputGroupName))
    }
    
    func removeGroup(_ inputIndexPath: Int) {
        groupList.remove(at: inputIndexPath)
    }
    
    //START - For editing group name
    func returnIndex(_ inputGroupName: String) -> Int! {
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
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).appendingPathComponent("GroupList.plist")
    }
    
    func saveGroupList() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(groupList, forKey: "GroupList")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    func loadGroupList() {
        let path = dataFilePath()
        
        if FileManager.default.fileExists(atPath: path) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                groupList = unarchiver.decodeObject(forKey: "GroupList") as! [GroupModel]
                unarchiver.finishDecoding()
            }
        }
    }
    //End
}
