//
//  Contact.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class Contact: Codable{
    
    //MARK: Properties
    var id: Int?
    var content: String
    var type: ContactType
    
    //MARK: Types
    enum CodingKeys: String, CodingKey {
        case Id = "id"
        case Content = "content"
        case ContactType = "type"
    }
    
    //MARK: Initializers
    init(content: String, type: ContactType) {
        self.content = content
        self.type = type
    }
    
    //MARK: Codable
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .Id)
        self.content = try values.decode(String.self, forKey: .Content)
        let type = try values.decode(Int.self, forKey: .ContactType)
        self.type = type == 1 ? ContactType.Cellphone : type == 2 ? ContactType.SocialNetwork : ContactType.Other
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .Id)
        try container.encode(self.content, forKey: .Content)
        try container.encode(self.type.rawValue, forKey: .ContactType)
    }
}
