//
//  Time.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 09/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

//MARK: ALIAS
typealias Interval = (from: Date, to: Date)

//MARK: ENUNS
enum GreetingType: Int{
    case GoodMorning = 1
    case GoodAfternoon = 2
    case GoodEvening = 3
    case GoodDawn = 4
}

enum ContactType: Int{
    case Cellphone = 1
    case SocialNetwork = 2
    case Other = 3
}

enum IntervalKey: String{
    case From = "From"
    case To = "To"
}

//MARK: STRUCTS
struct PreferenceKey{
    static let preferences = "preferences"
    static let keepConnected = "keepConnected"
    static let goodMorning = "goodMorning"
    static let goodAfternoon = "goodAfternoon"
    static let goodEvening = "goodEvening"
    static let goodDawn = "goodDawn"
    static let goodMorningInterval = "goodMorningInterval"
    static let goodAfternoonInterval = "goodAfternoonInterval"
    static let goodEveningInterval = "goodEveningInterval"
    static let goodDawnInterval = "goodDawnInterval"
    static let radius = "radius"
}

struct ActionKey{
    static let retribute = "Retribuir"
    static let like = "Curtir"
    static let liked = "Curtiu"
}


