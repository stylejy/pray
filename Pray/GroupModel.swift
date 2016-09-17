//
//  GroupModel.swift
//  Praying
//  Thanks God for all.
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
        groupName = aDecoder.decodeObject(forKey: "GroupName") as! String
        groupMembers = aDecoder.decodeObject(forKey: "GroupMembers") as! [MemberModel]
        super.init()
    }
    
    func returnIndex(_ inputGroupName: String) -> Int! {
        var count = 0
        for value in groupMembers {
            if value.name == inputGroupName {
                return count
            } else {
                count = count + 1
            }
        }
        return nil
    }
    
    func giveGroupMemberName(_ inputIndex: Int, inputName: String) {
        let newMember = MemberModel()
        newMember.name = inputName
        groupMembers.append(newMember)
    }
    
    func giveGroupMemberPray(_ inputIndex: Int, inputPrayer: String) {
        let newPrayer = PrayerModel()
        newPrayer.prayer = inputPrayer
        groupMembers[inputIndex].prayers.append(newPrayer)
    }
    
    func removeMember(_ inputIndex: Int) {
        groupMembers.remove(at: inputIndex)
    }
    
    //page p137-138
    func encodeWithCoder(_ aCoder: NSCoder) {
        aCoder.encode(groupName, forKey: "GroupName")
        aCoder.encode(groupMembers, forKey: "GroupMembers")
    }
    
}
