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
        addGroup("이 셀을 왼쪽으로 밀면 삭제 버튼이 나옵니다.")
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
    
    /*func returnIndex(inputGroupName) -> Int {
        
    }*/
    
    func addMember(inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.setGroupMemberName(inputMemberName)
    }
    
    func addPray(inputPray: String, inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.setGroupMemberPray(inputMemberName, inputPray: inputPray)
    }
    
    func removeGroup(inputIndexPath: Int) {
        groupList.removeAtIndex(inputIndexPath)
    }
}