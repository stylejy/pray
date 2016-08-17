//
//  MemberModel.swift
//  Pray
//
//  Created by 이주영 on 08/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import Foundation

class MemberModel: NSObject {
    var name: String = ""
    var prayers: [String] = []
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("MemberName") as! String
        prayers = aDecoder.decodeObjectForKey("Prayers") as! [String]
        super.init()
    }
    
    //For saving the details as a external file.
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "MemberName")
        aCoder.encodeObject(prayers, forKey: "Prayers")
    }
    
    func removePrayer(inputIndex: Int) {
        prayers.removeAtIndex(inputIndex)
    }
}