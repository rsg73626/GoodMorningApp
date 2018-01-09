//
//  PreferencesManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class PreferencesManager{
    
    //MARK: Singleton reference
    private static let _shared: PreferencesManager = PreferencesManager()
    static var shared: PreferencesManager {get {return _shared}}
    
    //MARK: Types
    private struct PreferencesKeys{
        static let preferences = "preferences
        "
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
    
    struct Time{
        var hours: Int
        var minutes: Int
        
        init(hours: Int, minutes: Int) {
            self.hours = hours
            self.minutes = minutes
        }
        
        func asString() -> String{
            return "\(hours):\(minutes)"
        }
    }
    
    enum IntervalKeys{
        case From
        case To
    }
    
    //MARK: Properties
    
    // On - Off Properties
    private var _keepConected: Bool = false
    private var _isGoodMorningActive: Bool = true
    private var _isGoodAfternoonActive: Bool = true
    private var _isGoodEveningActive: Bool = true
    private var _isGoodDawnActive: Bool = true
    
    // Interval Properties
    private var _goodMorningInterval: [IntervalKeys:Time]!
    private var _goodAfternoonInterval: [IntervalKeys:Time]!
    private var _goodEveningInterval: [IntervalKeys:Time]!
    private var _goodDawnInterval: [IntervalKeys:Time]!
    
    // Radius Properties
    private var _radius: Int = 100
    
    //MARK: Getters
    
    // On - Off Properties
    var keepConected: Bool {get {return self._keepConected}}
    var isGoodMorningActive: Bool {get {return self._isGoodMorningActive}}
    var isGoodAfternoonActive: Bool {get {return self._isGoodAfternoonActive}}
    var isGoodEveningActive: Bool {get {return self._isGoodEveningActive}}
    var isGoodDawnActive: Bool {get {return self._isGoodDawnActive}}
    
    // Interval Properties
    var goodMorningInterval: [IntervalKeys:Time]!
    var goodAfternoonInterval: [IntervalKeys:Time]!
    var goodEveningInterval: [IntervalKeys:Time]!
    var goodDawnInterval: [IntervalKeys:Time]!
    
    // Radius Properties
    var radius: Int = 100
    
    // Initializers
    
    private init(){
        
    }
    
    // MARK: Setters
    
    func changeKeepConnected(){
        
    }
    
    func changeIsGoodMorningActive(){
        
    }
    
    func changeIsGoodAfternoonActive(){
        
    }
    
    func changeIsGoodEveningActive(){
        
    }
    
    func changeIsGoodDawnActive(){
        
    }
    
    func changeGoodMorningInterval(){
        
    }
    
    func changeGoodAfternoonIntervar(){
        
    }
    
    func changeGoodEveningInterval(){
        
    }
    
    func changeGoodDawnInterval(){
        
    }
    
    func changeRadius(){
        
    }
    
    //MARK: Persistence functions
    
    private func loadData() -> [String:Any]{
        var defaultPreferences: [String:Any]!
        
        if let preferences = UserDefaults.standard.dictionary(forKey: PreferenceKey.preferences){
            defaultPreferences = preferences
        }else{
            defaultPreferences = [PreferenceKey.music: self._isMusicOn,
                                  PreferenceKey.sound: self._isSoundOn,
                                  PreferenceKey.token: self._token]
        }
        
        return defaultPreferences
    }
    
    private func saveData(){
        UserDefaults.standard.set(self.preferences, forKey: PreferenceKey.preferences)
        UserDefaults.standard.synchronize()
    }
}
