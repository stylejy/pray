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
    var prayers = [PrayerModel]()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "MemberName") as! String
        
        //First if statement is used to convert old data type(String) to new data type(PrayerModel) for old version users only.
        if (aDecoder.decodeObject(forKey: "Prayers") as? [String]) != nil {
            for stringPrayer in aDecoder.decodeObject(forKey: "Prayers") as! [String] {
                let newPrayerModel = PrayerModel()
                newPrayerModel.prayer = stringPrayer
                prayers.append(newPrayerModel)
            }
        } else {
            prayers = aDecoder.decodeObject(forKey: "Prayers") as! [PrayerModel]
        }
        
        super.init()
    }
    
    //For saving the details as a external file.
    func encodeWithCoder(_ aCoder: NSCoder) {
        aCoder.encode(name, forKey: "MemberName")
        aCoder.encode(prayers, forKey: "Prayers")
    }
    
    func removePrayer(_ inputIndex: Int) {
        prayers.remove(at: inputIndex)
    }
}
