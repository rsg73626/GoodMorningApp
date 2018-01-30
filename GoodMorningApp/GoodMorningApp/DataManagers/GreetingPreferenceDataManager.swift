//
//  GreetingPreferenceDataManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 30/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class GreetingPreferenceDatamanager {
    
    static func readById(_ id: Int, callback: @escaping (GreetingPreference?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.greetingPreference + "/\(id)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(nil)
            } else if let greetingPreferenceData = data {
                do {
                    let greetingPreferenceFromData: GreetingPreference = try decoder.decode(GreetingPreference.self, from: greetingPreferenceData)
                    callback(greetingPreferenceFromData)
                } catch {
                    print("Error while decoding greetingPreference: \(error).")
                    callback(nil)
                }
            } else {
                print("No data received from server.")
                callback(nil)
            }
        }
        task.resume()
    }
    
    static func readByUserId(_ userId: Int, callback: @escaping ([GreetingPreference]) -> Void) {
        let greetingPreferences: [GreetingPreference] = [GreetingPreference]()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.greetingPreference + "/user/\(userId)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(greetingPreferences)
            } else if let greetingPreferencesData = data {
                do {
                    let greetingPreferencesFromData: [GreetingPreference] = try decoder.decode([GreetingPreference].self, from: greetingPreferencesData)
                    callback(greetingPreferencesFromData)
                } catch {
                    print("Error while decoding greeting preferences: \(error).")
                    callback(greetingPreferences)
                }
            } else {
                print("No data received from server.")
                callback(greetingPreferences)
            }
        }
        task.resume()
    }
    
    static func update(_ greetingPreference: GreetingPreference, callback: @escaping (GreetingPreference?) -> Void) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.greetingPreference)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let greetingPreferenceData = try? encoder.encode(greetingPreference) {
            
            let task = URLSession.shared.uploadTask(with: request, from: greetingPreferenceData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let greetingPreferenceData = data{
                    do {
                        let greetingPreferenceFromData: GreetingPreference = try decoder.decode(GreetingPreference.self, from: greetingPreferenceData)
                        callback(greetingPreferenceFromData)
                    } catch {
                        print("Error while decoding greetingPreference: \(error).")
                        callback(nil)
                    }
                } else {
                    print("No data received from server.")
                    callback(nil)
                }
            }
            task.resume()
            
        } else {
            print("Error while encoding greetingPreference.")
            callback(nil)
        }
    }
    
}
