//
//  ActivityIndicatorManager.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 13/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class ActivityIndicatorManager {
    
    //MARK: Singleton
    private static let _shared: ActivityIndicatorManager = ActivityIndicatorManager()
    static var shared: ActivityIndicatorManager {get {return _shared}}
    
    //MARK: Properties
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var currentViewController: UIViewController?
    
    //MARK: Initializers
    private init(){
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = .gray
    }
    
    //MARK: ActivityIndicator functions
    func start(to viewController: UIViewController){
        self.currentViewController = viewController
        self.activityIndicator.center = viewController.view.center
        viewController.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stop(){
        if let viewController = self.currentViewController {
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            self.activityIndicator.removeFromSuperview()
            self.currentViewController = nil
        }
    }
    
    
    
}
