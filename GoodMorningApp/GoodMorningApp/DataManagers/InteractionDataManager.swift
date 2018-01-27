////
////  InteractionDataManager.swift
////  GoodMorningApp
////
////  Created by Renan Soares Germano on 08/01/2018.
////  Copyright © 2018 Renan Soares Germano. All rights reserved.
////
//
//import Foundation
//
//class InteractionDataManager: DataM//
//  InteractionDataManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class InteractionDataManager {
    static func create(idGreeting: Int, idUser: Int, callback: @escaping (Interaction?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.interaction)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let interactionDictionary: [String:Any] = ["id_greeting":idGreeting, "id_receiver":idUser]
        
        if let interactionString = Parser.shared.dictionaryToJSONString(interactionDictionary) {
            
            if let interactionData = interactionString.data(using: .utf8) {
                
                let task = URLSession.shared.uploadTask(with: request, from: interactionData) { data, response, error in
                    if let error = error {
                        print(error.localizedDescription)
                        callback(nil)
                    } else if let interactionData = data {
                        do {
                            let interactionFromData = try decoder.decode(Interaction.self, from: interactionData)
                            callback(interactionFromData)
                        } catch {
                            print("Error while decoding interaction: \(error).")
                            callback(nil)
                        }
                    } else {
                        print("No data received from server.")
                        callback(nil)
                    }
                }
                task.resume()
                
            } else {
                print("Error while encoding interaction.")
                callback(nil)
            }
        } else {
            print("Error while creating interaction json.")
            callback(nil)
        }
        
    }
    
    static func read(complete: Bool, callback: @escaping ([Interaction]) -> Void) {
        let interactions: [Interaction] = [Interaction]()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.interaction + "?complete=\(complete)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(interactions)
            } else if let interactionsData = data {
                do {
                    let interactionsFromData = try decoder.decode([Interaction].self, from: interactionsData)
                    callback(interactionsFromData)
                } catch {
                    print("Error while decoding interactions: \(error).")
                    callback(interactions)
                }
            } else {
                print("No data received from server.")
                callback(interactions)
            }
        }
        task.resume()
        
    }
    
    static func readById(_ id: Int, complete: Bool, callback: @escaping (Interaction?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.interaction + "/\(id)?complete=\(complete)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(nil)
            } else if let interactionData = data {
                do {
                    let interactionFromData: Interaction = try decoder.decode(Interaction.self, from: interactionData)
                    callback(interactionFromData)
                } catch {
                    print("Error while decoding interaction: \(error).")
                    callback(nil)
                }
            } else {
                print("No data received from server.")
                callback(nil)
            }
        }
        task.resume()
    }
    
    static func update(_ interaction: Interaction, callback: @escaping (Interaction?) -> Void) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.interaction)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let interactionData = try? encoder.encode(interaction) {
            
            let task = URLSession.shared.uploadTask(with: request, from: interactionData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let interactionData = data{
                    do {
                        let interactionFromData: Interaction = try decoder.decode(Interaction.self, from: interactionData)
                        callback(interactionFromData)
                    } catch {
                        print("Error while decoding interaction: \(error).")
                        callback(nil)
                    }
                } else {
                    print("No data received from server.")
                    callback(nil)
                }
            }
            task.resume()
            
        } else {
            print("Error while encoding interaction.")
            callback(nil)
        }
        
    }
    
    static func delete(_ id: Int, callback: @escaping (Interaction?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.interaction + "/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let interactionData = data{
                do {
                    let interaction: Interaction = try decoder.decode(Interaction  .self, from: interactionData)
                    callback(interaction)
                } catch {
                    print("Error while decoding interaction: \(error).")
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


