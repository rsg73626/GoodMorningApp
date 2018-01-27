////
////  GreetingDataManager.swift
////  GoodMorningApp
////
////  Created by Renan Soares Germano on 08/01/2018.
////  Copyright © 2018 Renan Soares Germano. All rights reserved.
////
//
//import Foundation
//
//class GreetingDataManager: DataM//
//  GreetingDataManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class GreetingDataManager {
    static func create(greeting: Greeting, idUser: Int, callback: @escaping (Greeting?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.greeting)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let greetingDictionary: [String:Any] = ["id_user":idUser, "greeting":["type":greeting.type.rawValue, "message":greeting.message, "date":Parser.shared.dateToString(greeting.date, format: "yyyy-MM-dd")!]]
        
        if let greetingString = Parser.shared.dictionaryToJSONString(greetingDictionary) {
            
            if let greetingData = greetingString.data(using: .utf8) {
                
                let task = URLSession.shared.uploadTask(with: request, from: greetingData) { data, response, error in
                    if let error = error {
                        print(error.localizedDescription)
                        callback(nil)
                    } else if let greetingData = data {
                        do {
                            let greetingFromData = try decoder.decode(Greeting.self, from: greetingData)
                            callback(greetingFromData)
                        } catch {
                            print("Error while decoding greeting: \(error).")
                            callback(nil)
                        }
                    } else {
                        print("No data received from server.")
                        callback(nil)
                    }
                }
                task.resume()
                
            } else {
                print("Error while encoding greeting.")
                callback(nil)
            }
        } else {
            print("Error while creating greeting json.")
            callback(nil)
        }
        
    }
    
    static func read(complete: Bool, callback: @escaping ([Greeting]) -> Void) {
        let greetings: [Greeting] = [Greeting]()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.greeting + "?complete=\(complete)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(greetings)
            } else if let greetingsData = data {
                do {
                    let greetingsFromData = try decoder.decode([Greeting].self, from: greetingsData)
                    callback(greetingsFromData)
                } catch {
                    print("Error while decoding greetings: \(error).")
                    callback(greetings)
                }
            } else {
                print("No data received from server.")
                callback(greetings)
            }
        }
        task.resume()
        
    }
    
    static func readById(_ id: Int, complete: Bool, callback: @escaping (Greeting?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.greeting + "/\(id)?complete=\(complete)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(nil)
            } else if let greetingData = data {
                do {
                    let greetingFromData: Greeting = try decoder.decode(Greeting.self, from: greetingData)
                    callback(greetingFromData)
                } catch {
                    print("Error while decoding greeting: \(error).")
                    callback(nil)
                }
            } else {
                print("No data received from server.")
                callback(nil)
            }
        }
        task.resume()
    }
    
    static func update(_ greeting: Greeting, callback: @escaping (Greeting?) -> Void) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.greeting)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let greetingData = try? encoder.encode(greeting) {
            
            let task = URLSession.shared.uploadTask(with: request, from: greetingData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let greetingData = data{
                    do {
                        let greetingFromData: Greeting = try decoder.decode(Greeting.self, from: greetingData)
                        callback(greetingFromData)
                    } catch {
                        print("Error while decoding greeting: \(error).")
                        callback(nil)
                    }
                } else {
                    print("No data received from server.")
                    callback(nil)
                }
            }
            task.resume()
            
        } else {
            print("Error while encoding greeting.")
            callback(nil)
        }
        
    }
    
    static func delete(_ id: Int, callback: @escaping (Greeting?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.greeting + "/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let greetingData = data{
                do {
                    let greeting: Greeting = try decoder.decode(Greeting  .self, from:   greetingData)
                    callback(greeting)
                } catch {
                    print("Error while decoding greeting: \(error).")
                    callback(nil)
                }
            } else {
                print("No data received from server.")
                callback(nil)
            }
        }
        task.resume()
    }
}

