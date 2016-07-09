//: Playground - noun: a place where people can play
//DB test

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

class GroupManagement {
    var groupList: [GroupModel] = []
    
    func addGroup(inputGroupName: String) {
        let newGroup = GroupModel()
        newGroup.setGroupName(inputGroupName)
        groupList.append(newGroup)
    }
    
    func returnGroupList() -> [GroupModel] {
        return groupList
    }
    
    func addMember(inputMemberName: String, inputGroupNum: Int) {
        let selectedGroup = groupList[inputGroupNum]
        selectedGroup.setGroupMemberName(inputMemberName)
    }
}

let result = GroupManagement()
result.addGroup("킹스크로스 한인교회")
result.addGroup("킹스 기도모임")
result.addGroup("런던대 연합 기도모임")

result.addMember("이주영", inputGroupNum: 0)
result.addMember("윤지훈", inputGroupNum: 0)


result.returnGroupList()[0]







