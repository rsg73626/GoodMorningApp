//
//  Contact.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class Contact{
    
    //MARK: Types
    enum ContactType{
        case Cellphone
        case SocialNetwork
        case Other
    }
    
    //MARK: Properties
    var id: Int?
    var content: String?
    var type: ContactType
    
    //MARK: Initializers
    init(content: String, type: ContactType) {
        self.content = content
        self.type = type
    }
    
    
}
