//
//  EditProfileViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 13/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userAbout: UITextView!
    @IBOutlet weak var userContact: UITextField!
    
    //MARK: Properties
    var user: User?
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user {
            self.userName.text = user.name!
//            self.userPhoto
            self.userEmail.text = user.email!
            self.userAbout.text = user.about!
            self.userContact.text = user.contacts.first?.content ?? "Adicione um contato"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func userPhotoTapped(_ sender: UITapGestureRecognizer) {
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
