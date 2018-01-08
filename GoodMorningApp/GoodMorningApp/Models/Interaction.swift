//
//  Interaction.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class Interaction{
    
    //MARK: Properties
    var greeting: Greeting
    var isRetributed: Bool = false
    var isLiked: Bool = false
    
    //MARK: Initializers
    init(greeting: Greeting, isRetributed: Bool, isLiked: Bool) {
        self.greeting = greeting
        self.isRetributed = isRetributed
        self.isLiked = isLiked
    }
    
}
