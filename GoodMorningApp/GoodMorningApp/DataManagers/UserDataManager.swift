//
//  UserDataManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class UserDataManager {
    static func create(_ user: User, callback: @escaping (User?) -> Void) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        print(APIURLs.user)
        let url = URL(string: APIURLs.user)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let userData = try? encoder.encode(user) {
            
            let task = URLSession.shared.uploadTask(with: request, from: userData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    callback(nil)
                } else if let userData = data {
                    do {
                        let userFromData = try decoder.decode(User.self, from: userData)
                        callback(userFromData)
                    } catch {
                        print("Error while decoding user: \(error).")
//                        let errorString = String(data: userData, encoding: .utf8)
//                        print(errorString)
                        callback(nil)
                    }
                } else {
                    print("No data received from server.")
                    callback(nil)
                }
            }
            task.resume()
            
        } else {
            print("Error while encoding user.")
            callback(nil)
        }
    }
    
    static func read(callback: @escaping ([User]) -> Void) {
        let users: [User] = [User]()
        let decoder = JSONDecoder()
        print(APIURLs.user)
        let url = URL(string: APIURLs.user)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(users)
            } else if let usersData = data {
                do {
                    let usersFromData = try decoder.decode([User].self, from: usersData)
                    callback(usersFromData)
                } catch {
                    print("Error while decoding users: \(error).")
                    callback(users)
                }
            } else {
                print("No data received from server.")
                callback(users)
            }
        }
        task.resume()
        
    }
    
    static func readById(_ id: Int, callback: @escaping (User?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.user + "/\(id)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(nil)
            } else if let userData = data {
                do {
                    let userFromData: User = try decoder.decode(User.self, from: userData)
                    callback(userFromData)
                } catch {
                    print("Error while decoding user: \(error).")
                    callback(nil)
                }
            } else {
                print("No data received from server.")
                callback(nil)
            }
        }
        task.resume()
    }
    
    static func update(_ user: User, callback: @escaping (User?) -> Void) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.user)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let userData = try? encoder.encode(user) {
            
            let task = URLSession.shared.uploadTask(with: request, from: userData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let userData = data{
                    do {
                        let userFromData: User = try decoder.decode(User.self, from: userData)
                        callback(userFromData)
                    } catch {
                        print("Error while decoding user: \(error).")
                        callback(nil)
                    }
                } else {
                    print("No data received from server.")
                    callback(nil)
                }
            }
            task.resume()
            
        } else {
            print("Error while encoding user.")
            callback(nil)
        }
        
    }
    
    static func delete(_ id: Int, callback: @escaping (User?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.user + "/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let userData = data{
                do {
                    let user: User = try decoder.decode(User.self, from: userData)
                    callback(user)
                } catch {
                    print("Error while decoding user: \(error).")
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
