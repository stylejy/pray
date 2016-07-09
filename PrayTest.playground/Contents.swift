//: Playground - noun: a place where people can play
//DB test

class GroupList {
    var group: [String] = []
    
    func addGroup(name: String) {
        group.append(name)
    }
    
    func returnGroup() -> [String] {
        return group
    }
}

let result = GroupList()

result.addGroup("킹스크로스 한인교회")
result.addGroup("킹스 기도모임")

result.returnGroup()



