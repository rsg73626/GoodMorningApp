//
//  Greeting.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class Greeting{
    
    //MARK: Types
    enum GreetingType{
        case GoodMorning
        case GoodAfternoon
        case GoodEvening
        case GoodDawn
    }
    
    //MARK: Properties
    var id: Int?
    var type: GreetingType?
    var message: String?
    var date: Date?
    var user: User?
    
    //MARK: Initializers
    init(type: GreetingType, message: String, date: Date?, user: User) {
        self.type = type
        self.message = message
        self.date = date
        self.user = user
    }
    
}
