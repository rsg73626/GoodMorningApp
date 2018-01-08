//
//  DataManagerProtocol.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    
    associatedtype T
    
    static func create(_: T, callback: @escaping (_ : T?) -> Void)
    static func read(_: T, callback: @escaping (_ : T?) -> Void)
    static func readById(_: Int, callback: @escaping (_ : [T]?) -> Void)
    static func update(_: T, callback: @escaping (_ : T?) -> Void)
    static func delete(_: T, callback: @escaping (_ : T?) -> Void)
}
