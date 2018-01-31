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
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userAbout: UITextView!
    @IBOutlet weak var userContact: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    
    //MARK: Properties
    var user: User?

    //MARK: Life sicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setUpUser()
        self.setUpAbout()
        self.setUpButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SetUp functions
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = AppColor.yellow
        self.navigationController?.navigationBar.tintColor = AppColor.blue
    }
    
    private func setUpButtons() {
        self.logoutButton.backgroundColor = AppColor.blue
        self.logoutButton.layer.cornerRadius = 5
        self.logoutButton.tintColor = UIColor.white
    }
    
    private func setUpUser() {
        self.userPhoto.clipsToBounds = true
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
        self.userAbout.textContainerInset.left = 13
        self.userAbout.textContainerInset.right = 13
    }
    
    //MARK: Actions
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        print("Logout button tapped!")
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
