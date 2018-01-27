//
//  Greeting.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class Greeting: Codable{
    
    //MARK: Properties
    var id: Int? = 0
    var type: GreetingType!
    var message: String!
    var date: Date!
    var creator: User?
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case GreetingType = "type"
        case Message = "message"
        case Date = "date"
        case Creator = "creator"
    }
    
    //MARK: Initializers
    init(type: GreetingType, message: String, date: Date) {
        self.id = nil
        self.type = type
        self.message = message
        self.date = date
        self.creator = nil
    }
    
    init(type: GreetingType, message: String, date: Date, creator: User) {
        self.type = type
        self.message = message
        self.date = date
        self.creator = creator
    }
    
    //MARK: Codable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { self.id = try values.decode(Int.self, forKey: .Id) } catch { self.id = nil }
        let type = try values.decode(Int.self, forKey: .GreetingType)
        self.type = type == 1 ? GreetingType.GoodMorning : type == 2 ? GreetingType.GoodAfternoon : type == 3 ? GreetingType.GoodEvening : GreetingType.GoodDawn
        self.message = try values.decode(String.self, forKey: .Message)
        let dateString = try values.decode(String.self, forKey: .Date)
        self.date = Parser.shared.stringToDate(dateString, format: "yyyy-MM-dd")
        do { self.creator = try values.decode(User.self, forKey: .Creator) } catch { self.creator = nil }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .Id)
        try container.encode(self.type.rawValue, forKey: .GreetingType)
        try container.encode(self.message, forKey: .Message)
        try container.encode(Parser.shared.dateToString(self.date!, format: "yyyy-MM-dd"), forKey: .Date)
        try container.encode(self.creator, forKey: .Creator)
    }
    
}
