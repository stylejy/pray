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
<<<<<<< HEAD
    var date = Date()
=======
    var date: NSDate!
>>>>>>> parent of ef60af4... My prayer scene's bug fixed(crash when new prayer added)
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        prayer = aDecoder.decodeObject(forKey: "Prayer") as! String
<<<<<<< HEAD
        
        if aDecoder.decodeObject(forKey: "IsOpen") != nil {
            isOpen = aDecoder.decodeObject(forKey: "IsOpen") as! Bool
        }
=======
        isOpen = aDecoder.decodeObject(forKey: "IsOpen") as! Bool
>>>>>>> parent of 1dd4024... codes for Swift 3.0
        
        if aDecoder.decodeObject(forKey: "Date") != nil {
            date = aDecoder.decodeObject(forKey: "Date") as! Date
        } else {
            date = Date()
        }
        super.init()
    }
    
    //For saving the details as a external file.
    func encodeWithCoder(_ aCoder: NSCoder) {
        aCoder.encode(prayer, forKey: "Prayer")
        aCoder.encode(isOpen, forKey: "IsOpen")
        aCoder.encode(date, forKey: "Date")
    }
}
