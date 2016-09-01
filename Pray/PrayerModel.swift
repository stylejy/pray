//
//  PrayerModel.swift
//  Pray
//
//  Created by 이주영 on 21/08/2016.
//  Copyright © 2016 이주영. All rights reserved.
//

import Foundation

class PrayerModel: NSObject {
    var prayer: String = ""
    var isOpen: Bool = false
    var date: NSDate!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        prayer = aDecoder.decodeObjectForKey("Prayer") as! String
        isOpen = aDecoder.decodeObjectForKey("IsOpen") as! Bool
        
        if aDecoder.decodeObjectForKey("Date") != nil {
            date = aDecoder.decodeObjectForKey("Date") as! NSDate
        } else {
            date = NSDate()
        }
        super.init()
    }
    
    //For saving the details as a external file.
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(prayer, forKey: "Prayer")
        aCoder.encodeObject(isOpen, forKey: "IsOpen")
        aCoder.encodeObject(date, forKey: "Date")
    }
}