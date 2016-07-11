//
//  GroupModel.swift
//  Pray
//
//  Created by 이주영 on 11/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import Foundation

class GroupModel {
    var groupName: String = ""
    var groupMembers: [String: String] = [:]
    
    func returnGroupName() -> String {
        return groupName
    }
    
    func returnGroupMembers() -> [String: String] {
        return groupMembers
    }
    
    func setGroupName(inputName: String) {
        groupName = inputName
    }
    
    func setGroupMemberName(inputName: String) {
        groupMembers[inputName] = ""
    }
    
    func setGroupMemberPray(inputName: String, inputPray: String) {
        groupMembers.updateValue(inputPray, forKey: inputName)
    }
}