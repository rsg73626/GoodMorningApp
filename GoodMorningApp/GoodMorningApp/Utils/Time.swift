//
//  Time.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 09/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation
import os.log

class Time: NSObject, NSCoding{
    
    var hours: Int
    var minutes: Int
    
    //MARK: Tipos
    struct PropertyKey{
        static let hours = "hours"
        static let minutes = "minutes"
    }
    
    //MARK: Initializers
    init(hours: Int, minutes: Int) {
        self.hours = hours
        self.minutes = minutes
    }
    
    //MARK: NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let hours = aDecoder.decodeObject(forKey: PropertyKey.hours) as? Int else{
            os_log("Error while decoding hour property.", log: OSLog.default, type: .error)
            return nil
        }
        guard let minutes = aDecoder.decodeObject(forKey: PropertyKey.minutes) as? Int else{
            os_log("Error while decoding minutes property.", log: OSLog.default, type: .error)
            return nil
        }
        self.init(hours: hours, minutes: minutes)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.hours, forKey: PropertyKey.hours)
        aCoder.encode(self.minutes, forKey: PropertyKey.minutes)
    }
    
    //MARK: Aux funcs
    func asString() -> String{
        return "\(hours):\(minutes)"
    }
}
