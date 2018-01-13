//
//  PorfileViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class PorfileViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userAbout: UITextView!
    @IBOutlet weak var userContact: UILabel!
    
    //MARK: Properties
    var user: User?

    //MARK: Life sicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user {
            userName.text = user.name!
            userEmail.text = user.email!
            userAbout.text = user.about!
            userContact.text = user.contacts.first?.content ?? "Adcione um contato."
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
