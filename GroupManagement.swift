//
//  GroupManagement.swift
//  Pray
//
//  Created by 이주영 on 11/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import Foundation

class GroupManagement {
    var groupList: [GroupModel] = []
    
    init() {
        //for testing
        addGroup("킹스크로스 한인교회")
        addGroup("킹스 기도모임")
        addGroup("런던대 연합 기도모임")
        //print("Group Management says \(returnNumOfGroups())")
    }
    
    func addGroup(inputGroupName: String) {
        let newGroup = GroupModel()
        newGroup.setGroupName(inputGroupName)
        groupList.append(newGroup)
    }
    
    func returnGroupList() -> [GroupModel] {
        return groupList
    }
    
    func returnNumOfGroups() -> Int {
        return groupList.count
    }
    
    func addMember(inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.setGroupMemberName(inputMemberName)
    }
    
    func addPray(inputPray: String, inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.setGroupMemberPray(inputMemberName, inputPray: inputPray)
    }
}