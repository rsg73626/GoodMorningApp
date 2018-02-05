//
//  Time.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 09/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation
import UIKit

//MARK: ALIAS
typealias Interval = (from: Date, to: Date)

//MARK: ENUNS
enum GreetingType: Int{
    case GoodMorning = 1
    case GoodAfternoon = 2
    case GoodEvening = 3
    case GoodDawn = 4
    static var stringList: [String] {get {return ["Bom dia", "Boa tarde", "Boa noite", "Boa madrugada"]}}
    static var list: [GreetingType] {get {return [GreetingType.GoodMorning, GreetingType.GoodAfternoon, GreetingType.GoodEvening, GreetingType.GoodDawn]}}
    var string: String {get {return self == .GoodMorning ? "Bom dia" : self == .GoodAfternoon ? "Boa tarde" : self == .GoodEvening ? "Boa noite" : "Boa madrugad"}}
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
struct TabBarIconImages {
    static let feed = #imageLiteral(resourceName: "feed")
    static let feedSelected = #imageLiteral(resourceName: "feed_selected")
    static let today = #imageLiteral(resourceName: "today")
    static let todaySelected = #imageLiteral(resourceName: "today_selected")
    static let adjusts = #imageLiteral(resourceName: "adjusts")
    static let adjustsSelected = #imageLiteral(resourceName: "adjusts_selected")
    static let profile = #imageLiteral(resourceName: "profile")
    static let profileSelected = #imageLiteral(resourceName: "profile_selected")
}

struct APIURLs {
    private static let domain = "http://ec2-18-220-95-177.us-east-2.compute.amazonaws.com/api"
    static var user: String {get {return domain + "/user"}}
    static var contact: String {get {return domain + "/contact"}}
    static var greetingPreference: String {get {return domain + "/greeting_preference"}}
    static var greeting: String {get {return domain + "/greeting"}}
    static var interaction: String {get {return domain + "/interaction"}}
}

struct AppColor {
    static let yellow = UIColor(patternImage: #imageLiteral(resourceName: "yellow"))
    static let blue = UIColor(patternImage: #imageLiteral(resourceName: "blue"))
    static let lightBlue = UIColor(patternImage: #imageLiteral(resourceName: "light_blue"))
    static let gray = UIColor(patternImage: #imageLiteral(resourceName: "gray"))
}

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


