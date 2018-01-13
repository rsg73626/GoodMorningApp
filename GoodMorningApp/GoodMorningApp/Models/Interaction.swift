//
//  Interaction.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class Interaction: Codable{
    
    //MARK: Properties
    var id: Int?
    var greeting: Greeting
    var isRetributed: Bool = false
    var isLiked: Bool = false
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case Greeting = "greeting"
        case GreetingId = "greeting_id"
        case IsRetributed = "is_retributed"
        case IsLiked = "is_liked"
    }
    
    //MARK: Initializers
    init(greeting: Greeting, isRetributed: Bool, isLiked: Bool) {
        self.greeting = greeting
        self.isRetributed = isRetributed
        self.isLiked = isLiked
    }
    
    //MARK: Codable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .Id)
        self.greeting = try values.decode(Greeting.self, forKey: .Greeting)
        self.isRetributed = try values.decode(Bool.self, forKey: .IsRetributed)
        self.isLiked = try values.decode(Bool.self, forKey: .IsLiked)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .Id)
        try container.encode(self.greeting.id, forKey: .GreetingId)
        try container.encode(self.isRetributed, forKey: .IsRetributed)
        try container.encode(self.isLiked, forKey: .IsLiked)
    }
    
}
