//
//  DataManagerTests.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 25/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

class DataManagerTests {
    static func run() {
        testUserDataManager()
//        testContactDataManager()
//        testGreetingDataManager()
//        testInteractionDataManager()
    }
    
    private static func testUserDataManager() {
        
        UserDataManager.read(callback: {users in
            print("\n*** Read ***")
            for user in users {
                print(user)
            }
            
            let contact = Contact(content: "1112345678", type: .Cellphone)
            let contact2 = Contact(content: "facebook.com/meuperfil", type: .SocialNetwork)
            let contact3 = Contact(content: "meunome@email.com.br", type: .Other)
            let user = User(name: "Nome do usuário", email: "meunome@email.com", password: "12345678", photo: "linkdaminhafotodeperfil", about: "Menu nome, minha idade. Moro em tal cidade. Trabalho e estudo", contacts: [contact, contact2, contact3])
            print("\n*** Created User ***")
            print(user)
            
            UserDataManager.create(user, callback: {user in
                print("\n*** Create ***")
                print(user)
                
                if let user = user {
                    UserDataManager.readById(user.id ?? 0, callback: {user in
                        print("\n*** Read by id ***")
                        print(user)
                        
                        if let user = user {
                            user.name = "Alterado"
                            user.email = "alterado@email.com.br"
                            user.about = "About alterado!"
                            
                            UserDataManager.update(user, callback: {user in
                                print("/n*** Update ***")
                                print(user)
                                
                                if let user = user {
                                    UserDataManager.delete(user.id ?? 0, callback: {user in
                                        print("\n*** Delete ***")
                                        print(user)
                                    })
                                }
                            })
                        }
                    })
                }
            })
        })
    
    }
    
    private static func testContactDataManager() {
        
        ContactDataManager.read(callback: {contacts in
            print("\n*** Read ***")
            for contact in contacts {
                print(contact)
            }
            
            let contact = Contact(content: "1112345678", type: .Cellphone)
            let contact2 = Contact(content: "facebook.com/meuperfil", type: .SocialNetwork)
            let contact3 = Contact(content: "meunome@email.com.br", type: .Other)
            let contacts = [contact, contact2, contact3]
            print("\n*** Created Contacts ***")
            print(contacts)
            
            ContactDataManager.create(contact: contact, idUser: 1, callback: {createdContact in
                print("\n*** Create ***")
                print(createdContact)
                
                ContactDataManager.create(contact: contact2, idUser: 1, callback: {createdContact in
                    print("\n*** Create ***")
                    print(createdContact)
                    
                    ContactDataManager.create(contact: contact3, idUser: 1, callback: {createdContact in
                        print("\n*** Create ***")
                        print(createdContact)
                        
                        if let createdContact = createdContact {
                            ContactDataManager.readById(createdContact.id ?? 0, callback: {contact in
                                print("\n*** Read by id ***")
                                print(contact)
                                
                                if let contact = contact {
                                    contact.content = "Novo conteúdo alterado!"
                                    ContactDataManager.update(contact, callback: {updatedContact in
                                        print("\n*** Update ***")
                                        print(updatedContact)
                                        
                                        if let updatedContact = updatedContact {
                                            ContactDataManager.delete(updatedContact.id ?? 0, callback: {deletedContact in
                                                print("\n*** Delete ***")
                                                print(deletedContact)
                                            })
                                        }
                                    })
                                }
                            })
                        }
                    })
                })
            })
        })
        
    }
    
    private static func testGreetingDataManager() {
        //read
        
        //create
        
        //read by id
        
        //update
        
        //delete
    }
    
    private static func testInteractionDataManager() {
        //read
        
        //create
        
        //read by id
        
        //update
        
        //delete
    }
}
