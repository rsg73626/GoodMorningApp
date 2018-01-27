//
//  ContactDataManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class ContactDataManager {
    static func create(contact: Contact, idUser: Int, callback: @escaping (Contact?) -> Void) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.contact)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let contactDictionary: [String:Any] = ["id_user":idUser, "contact":["content":contact.content, "type":contact.type.rawValue]]
        
        if let contactString = Parser.shared.dictionaryToJSONString(contactDictionary) {
            
            if let contactData = contactString.data(using: .utf8) {
                
                let task = URLSession.shared.uploadTask(with: request, from: contactData) { data, response, error in
                    if let error = error {
                        print(error.localizedDescription)
                        callback(nil)
                    } else if let contactData = data {
                        do {
                            let contactFromData = try decoder.decode(Contact.self, from: contactData)
                            callback(contactFromData)
                        } catch {
                            print("Error while decoding contact: \(error).")
                            callback(nil)
                        }
                    } else {
                        print("No data received from server.")
                        callback(nil)
                    }
                }
                task.resume()
                
            } else {
                print("Error while encoding contact.")
                callback(nil)
            }
        } else {
            print("Error while creating contact json.")
            callback(nil)
        }
        
    }
    
    static func read(callback: @escaping ([Contact]) -> Void) {
        let contacts: [Contact] = [Contact]()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.contact)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(contacts)
            } else if let contactsData = data {
                do {
                    let contactsFromData = try decoder.decode([Contact].self, from: contactsData)
                    callback(contactsFromData)
                } catch {
                    print("Error while decoding contacts: \(error).")
                    callback(contacts)
                }
            } else {
                print("No data received from server.")
                callback(contacts)
            }
        }
        task.resume()
        
    }
    
    static func readById(_ id: Int, callback: @escaping (Contact?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.contact + "/\(id)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                callback(nil)
            } else if let contactData = data {
                do {
                    let contactFromData: Contact = try decoder.decode(Contact.self, from: contactData)
                    callback(contactFromData)
                } catch {
                    print("Error while decoding contact: \(error).")
                    callback(nil)
                }
            } else {
                print("No data received from server.")
                callback(nil)
            }
        }
        task.resume()
    }
    
    static func update(_ contact: Contact, callback: @escaping (Contact?) -> Void) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.contact)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let contactData = try? encoder.encode(contact) {
            
            let task = URLSession.shared.uploadTask(with: request, from: contactData) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let contactData = data{
                    do {
                        let contactFromData: Contact = try decoder.decode(Contact.self, from: contactData)
                        callback(contactFromData)
                    } catch {
                        print("Error while decoding contact: \(error).")
                        callback(nil)
                    }
                } else {
                    print("No data received from server.")
                    callback(nil)
                }
            }
            task.resume()
            
        } else {
            print("Error while encoding contact.")
            callback(nil)
        }
        
    }
    
    static func delete(_ id: Int, callback: @escaping (Contact?) -> Void) {
        let decoder = JSONDecoder()
        let url = URL(string: APIURLs.contact + "/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let contactData = data{
                do {
                    let contact: Contact = try decoder.decode(Contact  .self, from: contactData)
                    callback(contact)
                } catch {
                    print("Error while decoding contact: \(error).")
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
