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
    var groupList: [GroupModel] = []
   
    func addGroup(inputGroupName: String) {
        let newGroup = GroupModel()
        newGroup.giveGroupName(inputGroupName)
        newGroup.giveGroupMemberName("test")
        groupList.append(newGroup)
    }
    
    func returnGroupList() -> [GroupModel] {
        return groupList
    }
    
    func returnNumOfGroups() -> Int {
        return groupList.count
    }
    
    func returnNumOfMembers(inputIndex: Int) -> Int {
        return groupList[inputIndex].returnGroupMembers().count
    }
    
    func returnMembers(inputIndex: Int) -> [String: String] {
        return groupList[inputIndex].returnGroupMembers()
    }
    
    //For editing group name
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
    
    func addMember(inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.giveGroupMemberName(inputMemberName)
    }
    
    func addPray(inputPray: String, inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.giveGroupMemberPray(inputMemberName, inputPray: inputPray)
    }
    
    func removeGroup(inputIndexPath: Int) {
        groupList.removeAtIndex(inputIndexPath)
    }
    
}