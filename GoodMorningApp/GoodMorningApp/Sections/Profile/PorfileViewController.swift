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
        self.setUpUser()
        self.setUpAbout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SetUp functions
    private func setUpUser() {
        if let user = self.user {
            userName.text = user.name!
            userEmail.text = user.email!
            userAbout.text = user.about!
            if let contact = self.user?.contacts?.first{
                self.userContact.text = contact.content
            }else{
                self.userContact.text = "Insira um contato."
            }
        }
    }
    
    private func setUpAbout() {
        let lightGray = UIColor.lightGray.withAlphaComponent(0.7)
        self.userAbout.layer.borderWidth = 0.3
        self.userAbout.layer.borderColor = UIColor.lightGray.cgColor
        self.userAbout.layer.cornerRadius = 5
        self.userAbout.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
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
