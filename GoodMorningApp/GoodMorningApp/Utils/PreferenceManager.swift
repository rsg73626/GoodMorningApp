//
//  PreferenceManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class PreferenceManager{
    
    //MARK: Singleton reference
    private static let _shared: PreferenceManager = PreferenceManager()
    static var shared: PreferenceManager {get {return _shared}}
    
    //MARK: Types
    private struct PreferenceKeys{
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
    
    enum IntervalKeys{
        case From
        case To
    }
    
    //MARK: Properties
    private var preferences: [String:Any]!
    
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
        self._keepConected = !self._keepConected
        self.preferences[PreferenceKeys.keepConnected] = self._keepConected
        self.saveData()
    }
    
    func changeIsGoodMorningActive(){
        self._isGoodMorningActive = !self._isGoodMorningActive
        self.preferences[PreferenceKeys.goodMorning] = self._isGoodMorningActive
        self.saveData()
    }
    
    func changeIsGoodAfternoonActive(){
        self._isGoodAfternoonActive = !self._isGoodAfternoonActive
        self.preferences[PreferenceKeys.goodAfternoon] = self._isGoodAfternoonActive
        self.saveData()
    }
    
    func changeIsGoodEveningActive(){
        self._isGoodEveningActive = !self._isGoodEveningActive
        self.preferences[PreferenceKeys.goodEvening] = self._isGoodEveningActive
        self.saveData()
    }
    
    func changeIsGoodDawnActive(){
        self._isGoodDawnActive = !self._isGoodDawnActive
        self.preferences[PreferenceKeys.goodDawn] = self._isGoodDawnActive
        self.saveData()
    }
    
    func changeGoodMorningInterval(to time: [IntervalKeys:Time]){
        self._goodMorningInterval = time
        self.preferences[PreferenceKeys.goodMorningInterval] = time
        self.saveData()
    }
    
    func changeGoodAfternoonIntervar(to time: [IntervalKeys:Time]){
        self._goodAfternoonInterval = time
        self.preferences[PreferenceKeys.goodAfternoonInterval] = time
        self.saveData()
    }
    
    func changeGoodEveningInterval(to time: [IntervalKeys:Time]){
        self._goodEveningInterval = time
        self.preferences[PreferenceKeys.goodEveningInterval] = time
        self.saveData()
    }
    
    func changeGoodDawnInterval(to time: [IntervalKeys:Time]){
        self._goodDawnInterval = time
        self.preferences[PreferenceKeys.goodDawnInterval] = time
        self.saveData()
    }
    
    func changeRadius(to value: Int){
        self._radius = value
        self.preferences[PreferenceKeys.radius] = value
        self.saveData()
    }
    
    //MARK: Persistence functions
    
    private func loadData() -> [String:Any]{
        var defaultPreference: [String:Any]!
        
        if let preferences = UserDefaults.standard.dictionary(forKey: PreferenceKeys.preferences){
            defaultPreference = preferences
        }else{
            defaultPreference = [
                PreferenceKeys.keepConnected: self._keepConected,
                PreferenceKeys.goodMorning: self._isGoodMorningActive,
                PreferenceKeys.goodAfternoon: self._isGoodAfternoonActive,
                PreferenceKeys.goodEvening: self._isGoodEveningActive,
                PreferenceKeys.goodDawn: self._isGoodDawnActive,
                PreferenceKeys.goodMorningInterval: self._goodMorningInterval,
                PreferenceKeys.goodAfternoonInterval: self._goodAfternoonInterval,
                PreferenceKeys.goodEveningInterval: self._goodEveningInterval,
                PreferenceKeys.goodDawnInterval: self._goodDawnInterval,
                PreferenceKeys.radius: self._radius
            ]
        }
        
        return defaultPreference
    }
    
    private func saveData(){
        UserDefaults.standard.set(self.preferences, forKey: PreferenceKeys.preferences)
        UserDefaults.standard.synchronize()
    }
}
