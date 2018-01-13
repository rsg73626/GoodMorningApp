//
//  User.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class User: Codable{
    
    //MARK: Properties
    var id: Int?
    var name: String?
    var email: String?
    var photo: String?
    var about: String?
    var contacts: [Contact] = [Contact]()
    
    //MARK: Initializers
    init(name: String, email: String, photo: String, about: String) {
        self.name = name
        self.email = email
        self.photo = photo
        self.about = about
    }
    
    init(name: String, email: String, photo: String, about: String, contacts: [Contact]) {
        self.name = name
        self.email = email
        self.photo = photo
        self.about = about
        self.contacts = contacts
    }
}
