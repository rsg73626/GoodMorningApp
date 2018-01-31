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
    private let greetings = ["Bom dia", "Boa tarde", "Boa noite", "Boa madrugada"]
    
    //MARK: Outlets
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var action: UIButton!
    @IBOutlet weak var sentByHeader: UIView!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var about: UITextView!
    @IBOutlet weak var contact: UIButton!
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpHeaders()
        self.setUpInteracton()
        self.setUpTextViews()
        self.setUpButtons()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SetUp functions
    private func setUpHeaders() {
        let type = self.interaction?.greeting.type.rawValue ?? 1
        self.navigationItem.title = self.greetings[type-1]
        self.sentByHeader.backgroundColor = AppColor.lightBlue
        self.userPhoto.clipsToBounds = true
    }
    
    private func setUpInteracton() {
        if let interaction = self.interaction{
            self.message.text = interaction.greeting.message
            
            if let isRetribuited = self.interaction?.isRetributed {
                if !isRetribuited {
                    self.action.setTitle(ActionKey.retribute, for: .normal)
                }else if let isLikedByReciever = self.interaction?.isLikedByReceiver {
                    
                    if isLikedByReciever{
                        self.action.setTitle(ActionKey.liked, for: .normal)
                        self.action.isEnabled = false
                    }else{
                        self.action.setTitle(ActionKey.like, for: .normal)
                    }
                    
                }
            }
            
            //TODO: implement user photo
            self.userName.text = interaction.greeting.creator?.name!
            self.about.text = interaction.greeting.creator?.about!
            
            if let isLikedBySender = self.interaction?.isLikedBySender, isLikedBySender {
                if let contact = self.interaction?.greeting.creator?.contacts?.first?.content {
                    self.contact.titleLabel?.text = contact
                }
            }else{
                self.contact.titleLabel?.text = "Contato não liberado."
            }
            
        }
    }
    
    private func setUpTextViews() {
        self.message.layer.borderWidth = 0.3
        self.message.layer.borderColor = UIColor.lightGray.cgColor
        self.message.layer.cornerRadius = 5
        self.message.textContainerInset.left = 13
        self.message.textContainerInset.right = 13
        self.about.layer.borderWidth = 0.3
        self.about.layer.borderColor = UIColor.lightGray.cgColor
        self.about.layer.cornerRadius = 5
        self.about.textContainerInset.left = 13
        self.about.textContainerInset.left = 13
    }
    
    private func setUpButtons() {
        self.action.backgroundColor = AppColor.blue
        self.action.tintColor = UIColor.white
        self.action.layer.cornerRadius = 5
        self.contact.backgroundColor = AppColor.blue
        self.contact.tintColor = UIColor.white
        self.contact.layer.cornerRadius = 5
    }
    
    //MARK: Actions
    @IBAction func actionTapped(_ sender: Any) {
        print("action tapped!")
    }
    
    @IBAction func contactTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Contato", message: "Escolha uma opção.", preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Salvar contato", style: .default, handler: nil)
        let callAction = UIAlertAction(title: "Ligar", style: .default, handler : nil)
        let copyAction = UIAlertAction(title: "Copiar", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(callAction)
        alert.addAction(copyAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
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
