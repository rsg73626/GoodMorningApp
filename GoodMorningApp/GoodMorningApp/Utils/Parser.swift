
//
//  DateFormatter.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 09/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class Parser{
    //MARK: Singleton
    private static let _shared: Parser = Parser()
    static var shared: Parser {get {return _shared}}
    
    //MARK: Properties
    private var dateFormatter = DateFormatter()
    
    //MARK: Initializers
    private init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.locale = Locale.init(identifier: "pt_BR")
        self.dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
    }
    
    //MARK: Parse functions
    func stringToDate(_ string: String) -> Date?{
        return self.stringToDate(string, format: "HH:mm")
    }
    
    func dateToString(_ date: Date) -> String?{
        return self.dateToString(date, format: "HH:mm")
    }
    
    func dateToString(_ date: Date, format: String) -> String?{
        self.dateFormatter.dateFormat = format
        return self.dateFormatter.string(from: date)
    }
    
    func stringToDate(_ string: String, format: String) -> Date?{
        self.dateFormatter.dateFormat = format
        return self.dateFormatter.date(from: string)
    }
    
    func jsonStringToDictionary(_ jsonString: String) -> [String:Any]? {
        if let data = jsonString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func dictionaryToJSONString(_ dictionary: [String:Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            return nil
        }
    }
    
    
    
}
