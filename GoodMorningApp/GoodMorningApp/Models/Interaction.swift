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
    var id: Int? = 0
    var greeting: Greeting!
    var isRetributed: Bool!
    var isLikedBySender: Bool!
    var isLikedByReceiver: Bool!
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case Greeting = "greeting"
        case IsRetributed = "is_retributed"
        case IsLikedBySender = "is_liked_by_sender"
        case IsLikedByReceiver = "is_liked_by_receiver"
    }
    
    //MARK: Initializers 
    init(greeting: Greeting, isRetributed: Bool, isLikedBySender: Bool, isLikedByReceiver: Bool) {
        self.id = nil
        self.greeting = greeting
        self.isRetributed = isRetributed
        self.isLikedBySender = isLikedBySender
        self.isLikedByReceiver = isLikedByReceiver
    }
    
    //MARK: Codable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { self.id = try values.decode(Int.self, forKey: .Id) } catch { self.id = nil }
        self.greeting = try values.decode(Greeting.self, forKey: .Greeting)
        self.isRetributed = try values.decode(Bool.self, forKey: .IsRetributed)
        self.isLikedBySender = try values.decode(Bool.self, forKey: .IsLikedBySender)
        self.isLikedByReceiver = try values.decode(Bool.self, forKey: .IsLikedByReceiver)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .Id)
        try container.encode(self.greeting!, forKey: .Greeting)
        try container.encode(self.isRetributed, forKey: .IsRetributed)
        try container.encode(self.isLikedBySender, forKey: .IsLikedBySender)
        try container.encode(self.isLikedByReceiver, forKey: .IsLikedByReceiver)
    }
    
}
