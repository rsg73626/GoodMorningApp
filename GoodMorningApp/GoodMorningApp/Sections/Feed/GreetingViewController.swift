//
//  GreetingViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController {
    
    //MARK: Properties
    var interaction: Interaction?
    
    //MARK: Outlets
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var action: UIButton!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var about: UITextView!
    @IBOutlet weak var contact: UIButton!
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpInteracton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SetUp functions
    private func setUpInteracton(){
        if let interaction = self.interaction{
            self.message.text = interaction.greeting.message
            if !interaction.isRetributed{
                self.action.titleLabel?.text = ActionKey.retribute
            }else if !interaction.isLiked{
                self.action.titleLabel?.text = ActionKey.like
            }else{
                self.action.titleLabel?.text = ActionKey.liked
                self.action.isEnabled = false
            }
            //TODO: implement user photo
            self.userName.text = interaction.greeting.user?.name!
            self.about.text = interaction.greeting.user?.about!
            self.contact.titleLabel?.text = interaction.greeting.user?.contacts.first?.content
        }
    }
    
    //MARK: Actions
    @IBAction func actionTapped(_ sender: Any) {
        
    }
    
    @IBAction func contactTapped(_ sender: Any) {
        
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
