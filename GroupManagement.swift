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
        addGroup("LCC 기도모임")
        addGroup("사랑샘 교회")
        addGroup("순복음 교회")
        addGroup("꿈이 있는 교회")
        addGroup("런던 한인 교회")
        addGroup("1")
        addGroup("2")
        addGroup("3")
        addGroup("4")
        addGroup("5 한인교회")
        addGroup("킹스 6")
        addGroup("7 연합 기도모임")
        addGroup("8 기도모임")
        addGroup("9 한인교회")
        addGroup("킹스 10")
        addGroup("런던대 12 기도모임")
        addGroup("13 기도모임")
        addGroup("킹스크로스 14")
        addGroup("킹스 15")
        addGroup("16 연합 기도모임")
        addGroup("17 기도모임")
    }
    
    func addGroup(inputGroupName: String) {
        let newGroup = GroupModel()
        newGroup.setGroupName(inputGroupName)
        groupList.append(newGroup)
    }
    
    func returnGroupList() -> [GroupModel] {
        return groupList
    }
    
    func numOfGroups() -> Int {
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