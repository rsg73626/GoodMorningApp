//
//  PreferenceManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class PreferenceManager{
    
    //MARK: Singleton
    private static let _shared: PreferenceManager = PreferenceManager()
    static var shared: PreferenceManager {get {return _shared}}
    
    //MARK: Properties
    private var preferences: [String:Any]!
    private var parser = Parser.shared
    private var _radius: Int = 1
    
    //MARK: On - Off Properties
    private var _keepConected: Bool = false
    private var _isGoodMorningActive: Bool = true
    private var _isGoodAfternoonActive: Bool = true
    private var _isGoodEveningActive: Bool = true
    private var _isGoodDawnActive: Bool = true
    
    //MARK: Interval Properties
    private var _goodMorningInterval = [IntervalKey.From.rawValue:"06:01", IntervalKey.To.rawValue:"12:00"]
    private var _goodAfternoonInterval = [IntervalKey.From.rawValue:"12:01", IntervalKey.To.rawValue:"18:00"]
    private var _goodEveningInterval = [IntervalKey.From.rawValue:"18:01", IntervalKey.To.rawValue:"00:00"]
    private var _goodDawnInterval = [IntervalKey.From.rawValue:"00:01", IntervalKey.To.rawValue:"06:00"]

    //MARK: Getters
    var radius: Int {get {return self._radius}}
    
    //MARK: On - Off getters
    var keepConected: Bool {get {return self._keepConected}}
    var isGoodMorningActive: Bool {get {return self._isGoodMorningActive}}
    var isGoodAfternoonActive: Bool {get {return self._isGoodAfternoonActive}}
    var isGoodEveningActive: Bool {get {return self._isGoodEveningActive}}
    var isGoodDawnActive: Bool {get {return self._isGoodDawnActive}}
    
    //MARK: Intervals getters
    var goodMorningInterval:Interval {
        get{
            return (parser.stringToDate(_goodMorningInterval[IntervalKey.From.rawValue]!)!, parser.stringToDate(_goodMorningInterval[IntervalKey.To.rawValue]!)!)
        }
    }
    var goodAfternoonInterval:Interval {
        get{
            return (parser.stringToDate(_goodAfternoonInterval[IntervalKey.From.rawValue]!)!, parser.stringToDate(_goodAfternoonInterval[IntervalKey.To.rawValue]!)!)
        }
    }
    var goodEveningInterval:Interval {
        get{
            return (parser.stringToDate(_goodEveningInterval[IntervalKey.From.rawValue]!)!, parser.stringToDate(_goodEveningInterval[IntervalKey.To.rawValue]!)!)
        }
    }
    var goodDawnInterval:Interval {
        get{
            return (parser.stringToDate(_goodDawnInterval[IntervalKey.From.rawValue]!)!, parser.stringToDate(_goodDawnInterval[IntervalKey.To.rawValue]!)!)
        }
    }
    
    // MARK: Initializers
    private init(){
        self.preferences = self.loadData()
        self._keepConected = self.preferences[PreferenceKey.keepConnected] as! Bool
        self._isGoodMorningActive = self.preferences[PreferenceKey.goodMorning] as! Bool
        self._isGoodAfternoonActive = self.preferences[PreferenceKey.goodAfternoon] as! Bool
        self._isGoodEveningActive = self.preferences[PreferenceKey.goodEvening] as! Bool
        self._isGoodDawnActive = self.preferences[PreferenceKey.goodDawn] as! Bool
        self._goodMorningInterval = self.preferences[PreferenceKey.goodMorningInterval] as! [String:String]
        self._goodAfternoonInterval = self.preferences[PreferenceKey.goodAfternoonInterval] as! [String:String]
        self._goodEveningInterval = self.preferences[PreferenceKey.goodEveningInterval] as! [String:String]
        self._goodDawnInterval = self.preferences[PreferenceKey.goodDawnInterval] as! [String:String]
        self._radius = self.preferences[PreferenceKey.radius] as! Int
    }
    
    // MARK: Setters
    func changeRadius(to value: Int){
        self._radius = value
        self.preferences[PreferenceKey.radius] = value
        self.saveData()
    }
    
    func changeKeepConnected(){
        self._keepConected = !self._keepConected
        self.preferences[PreferenceKey.keepConnected] = self._keepConected
        self.saveData()
    }
    
    func changeIsGoodMorningActive(){
        self._isGoodMorningActive = !self._isGoodMorningActive
        self.preferences[PreferenceKey.goodMorning] = self._isGoodMorningActive
        self.saveData()
    }
    
    func changeIsGoodAfternoonActive(){
        self._isGoodAfternoonActive = !self._isGoodAfternoonActive
        self.preferences[PreferenceKey.goodAfternoon] = self._isGoodAfternoonActive
        self.saveData()
    }
    
    func changeIsGoodEveningActive(){
        self._isGoodEveningActive = !self._isGoodEveningActive
        self.preferences[PreferenceKey.goodEvening] = self._isGoodEveningActive
        self.saveData()
    }
    
    func changeIsGoodDawnActive(){
        self._isGoodDawnActive = !self._isGoodDawnActive
        self.preferences[PreferenceKey.goodDawn] = self._isGoodDawnActive
        self.saveData()
    }
    
    func changeGoodMorningInterval(key: IntervalKey, to date: Date){
        self._goodMorningInterval[key.rawValue] = parser.dateToString(date)!
        self.preferences[PreferenceKey.goodMorningInterval] = self._goodMorningInterval
        self.saveData()
    }
    
    func changeGoodAfternoonIntervar(key: IntervalKey, to date: Date){
        self._goodAfternoonInterval[key.rawValue] = parser.dateToString(date)!
        self.preferences[PreferenceKey.goodAfternoonInterval] = self._goodAfternoonInterval
        self.saveData()
    }
    
    func changeGoodEveningInterval(key: IntervalKey, to date: Date){
        self._goodEveningInterval[key.rawValue] = parser.dateToString(date)!
        self.preferences[PreferenceKey.goodEveningInterval] = self._goodEveningInterval
        self.saveData()
    }
    
    func changeGoodDawnInterval(key: IntervalKey, to date: Date){
        self._goodDawnInterval[key.rawValue] = parser.dateToString(date)!
        self.preferences[PreferenceKey.goodDawnInterval] = self._goodDawnInterval
        self.saveData()
    }
    
    //MARK: Persistence functions
    private func loadData() -> [String:Any]{
        var defaultPreference: [String:Any]!
        
        if let preferences = UserDefaults.standard.dictionary(forKey: PreferenceKey.preferences){
            defaultPreference = preferences
            print("Preferencias de UserDefaults!")
        }else{
            print("Preferencias Default!")
            defaultPreference = [
                PreferenceKey.keepConnected: self._keepConected,
                PreferenceKey.goodMorning: self._isGoodMorningActive,
                PreferenceKey.goodAfternoon: self._isGoodAfternoonActive,
                PreferenceKey.goodEvening: self._isGoodEveningActive,
                PreferenceKey.goodDawn: self._isGoodDawnActive,
                PreferenceKey.goodMorningInterval: self._goodMorningInterval,
                PreferenceKey.goodAfternoonInterval: self._goodAfternoonInterval,
                PreferenceKey.goodEveningInterval: self._goodEveningInterval,
                PreferenceKey.goodDawnInterval: self._goodDawnInterval,
                PreferenceKey.radius: self._radius
            ]
        }
        
        return defaultPreference
    }
    
    private func saveData(){
        UserDefaults.standard.set(self.preferences, forKey: PreferenceKey.preferences)
        UserDefaults.standard.synchronize()
    }
}
