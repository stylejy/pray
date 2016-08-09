//
//  GroupModel.swift
//  Pray
//
//  Created by 이주영 on 11/07/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import Foundation

class GroupModel: NSObject {
    var groupName = ""
    var groupMembers = [MemberModel]()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        groupName = aDecoder.decodeObjectForKey("GroupName") as! String
        groupMembers = aDecoder.decodeObjectForKey("GroupMembers") as! [MemberModel]
        super.init()
    }
    
    func returnGroupName() -> String {
        return groupName
    }
    
    func returnGroupMembers() -> [MemberModel] {
        return groupMembers
    }
    
    func returnNumOfMembers() -> Int {
        return groupMembers.count
    }
    
    func giveGroupName(inputName: String) {
        groupName = inputName
    }
    
    func giveGroupMemberName(inputIndex: Int, inputName: String) {
        let newMember = MemberModel()
        newMember.name = inputName
        groupMembers.append(newMember)
    }
    
    func giveGroupMemberPray(inputIndex: Int, inputPrayer: String) {
        groupMembers[inputIndex].prayers.append(inputPrayer)
    }
    
    //page p137-138
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(groupName, forKey: "GroupName")
        aCoder.encodeObject(groupMembers, forKey: "GroupMembers")
    }
    
}