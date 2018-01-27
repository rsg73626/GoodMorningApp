//
//  CodableTests.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 23/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

public class CodableTests {
    
    static func run() {
        print("\n*** Codable tests ***")
        testUserCodable()
        testContactCodable()
        testGreetingCodable()
        testInteractionCodable()
    }
    
    private static func testUserCodable() {
        let encoder: JSONEncoder = JSONEncoder()
        let decoder: JSONDecoder = JSONDecoder()
        let contact = Contact(content: "1112345678", type: .Cellphone)
        let contact2 = Contact(content: "facebook.com/meuperfil", type: .SocialNetwork)
        let contact3 = Contact(content: "meunome@email.com.br", type: .Other)
        let user = User(name: "Nome do usuário", email: "meunome@email.com", password: "12345678", photo: "linkdaminhafotodeperfil", about: "Menu nome, minha idade. Moro em tal cidade. Trabalho e estudo", contacts: [contact, contact2, contact3])
        print("\n*** Created User ***")
        print(user)
        
        let userData = try? encoder.encode(user)
        let userString = String(data: userData!, encoding: .utf8)
        print("\n*** Encoded User ***")
        print(userString ?? "")
        
        let decodeUser = try? decoder.decode(User.self, from: userData!)
        print("\n*** Decoded User ***")
        print(decodeUser!)
    }
    
    private static func testContactCodable() {
        let encoder: JSONEncoder = JSONEncoder()
        let decoder: JSONDecoder = JSONDecoder()
        let contact = Contact(content: "1112345678", type: .Cellphone)
        let contact2 = Contact(content: "facebook.com/meuperfil", type: .SocialNetwork)
        let contact3 = Contact(content: "meunome@email.com.br", type: .Other)
        let contacts = [contact, contact2, contact3]
        print("\n*** Created Contacts ***")
        print(contacts)
        
        let contactsData = try? encoder.encode(contacts)
        let contactsString = String(data: contactsData!, encoding: .utf8)
        print("\n*** Encoded Contacts ***")
        print(contactsString ?? "")
        
        let decodedContacts = try? decoder.decode([Contact].self, from: contactsData!)
        print("\n*** Decoded Contacts ***")
        print(decodedContacts!)
    }
    
    private static func testGreetingCodable() {
        let encoder: JSONEncoder = JSONEncoder()
        let decoder: JSONDecoder = JSONDecoder()
        
        let contact = Contact(content: "1112345678", type: .Cellphone)
        let contact2 = Contact(content: "facebook.com/meuperfil", type: .SocialNetwork)
        let contact3 = Contact(content: "meunome@email.com.br", type: .Other)
        let user = User(name: "Nome do usuário", email: "meunome@email.com", password: "12345678", photo: "linkdaminhafotodeperfil", about: "Menu nome, minha idade. Moro em tal cidade. Trabalho e estudo", contacts: [contact, contact2, contact3])
        let greeting = Greeting(type: .GoodEvening, message: "Que a sua noite seja ótima!", date: Date(), creator: user)
        print("\n*** Created Greeting ***")
        print(greeting)
        
        let greetingData = try? encoder.encode(greeting)
        let greetingString = String.init(data: greetingData!, encoding: .utf8)
        print("\n*** Encoded Greeting ***")
        print(greetingString ?? "")

        let decodedGreeting = try? decoder.decode(Greeting.self, from: greetingData!)
        print("\n*** Decoded Greeting ***")
        print(decodedGreeting!)
    }
    
    private static func testInteractionCodable() {
        let encoder: JSONEncoder = JSONEncoder()
        let decoder: JSONDecoder = JSONDecoder()
        
        let contact = Contact(content: "1112345678", type: .Cellphone)
        let contact2 = Contact(content: "facebook.com/meuperfil", type: .SocialNetwork)
        let contact3 = Contact(content: "meunome@email.com.br", type: .Other)
        let user = User(name: "Nome do usuário", email: "meunome@email.com", password: "12345678", photo: "linkdaminhafotodeperfil", about: "Menu nome, minha idade. Moro em tal cidade. Trabalho e estudo", contacts: [contact, contact2])
        let greeting = Greeting(type: .GoodEvening, message: "Que a sua noite seja ótima!", date: Date(), creator: user)
        print("\n*** Created Greeting ***")
        print(greeting)
        let interaction = Interaction(greeting: greeting, isRetributed: false, isLikedBySender: false, isLikedByReceiver: false)
        print("\n*** Created Interaction ***")
        print(interaction)
        
        let interactionData = try? encoder.encode(interaction)
        let interactionString = String.init(data: interactionData!, encoding: .utf8)
        print("\n*** Encoded Interaction ***")
        print(interactionString ?? "")
        
        let decodedInteraction = try? decoder.decode(Interaction.self, from: interactionData!)
        print("\n*** Decoded Interaction ***")
        print(decodedInteraction!)
    }
}
