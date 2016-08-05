//
//  GroupModel.swift
//  Pray
//
//  Created by 이주영 on 11/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import Foundation

class GroupModel: NSObject {
    var groupName: String = ""
    var groupMembers: [String: String] = [:]
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        groupName = aDecoder.decodeObjectForKey("GroupName") as! String
        super.init()
    }
    
    func returnGroupName() -> String {
        return groupName
    }
    
    func returnGroupMembers() -> [String: String] {
        return groupMembers
    }
    
    func giveGroupName(inputName: String) {
        groupName = inputName
    }
    
    func giveGroupMemberName(inputName: String) {
        groupMembers[inputName] = ""
    }
    
    func giveGroupMemberPray(inputName: String, inputPray: String) {
        groupMembers.updateValue(inputPray, forKey: inputName)
    }
    
    //page p137-138
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(groupName, forKey: "GroupName")
    }
    
}