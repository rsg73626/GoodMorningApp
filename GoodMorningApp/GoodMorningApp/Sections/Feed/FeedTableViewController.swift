//
//  FeedTableViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    //MARK: Properties
    private var interactions: [Interaction]!
    var selectedInteraction: Interaction?
    
    //MARK: Outlets
    @IBOutlet weak var filter: UIBarButtonItem!
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactions = [Interaction]()
        let user = User(name: "Renan Soares Germano", email: "renan.rsg@hotmail.com", password: "", photo: "userphoto", about: "20 anos, estudante de ciência da computação. Desenvolvedore iOS.", contacts: [Contact(content: "11 91234 5678", type: .Cellphone)])
        for i in 1...5 {
            let greeting = Greeting(type: .GoodMorning, message: "Muito bom dia pra você que leu! Que tudo de bom te aconteça hoje! \(i)", date: Date(), creator: user)
            self.interactions.append(Interaction(greeting: greeting, isRetributed: false, isLikedBySender: false, isLikedByReceiver: false))
        }
            
        self.setUpNavigationBar()
        self.setUpTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.interactions?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "greeting", for: indexPath) as? GreetingTableViewCell else {
            fatalError("Imporssible to conver UITableViewCell to GreetingTableViewCell.")
        }
        let index = indexPath.row
        cell.message.restorationIdentifier = "\(index)"
        self.setUpCellLayout(cell)
        self.setUpCell(cell: cell, interaction: self.interactions[index])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 344
    }
    
    //MARK: SetUp functions
    private func setUpNavigationBar() {
        if self.navigationItem.rightBarButtonItem == self.filter {
            self.filter.isEnabled = false
            self.navigationItem.rightBarButtonItem = nil
        }
        self.navigationController?.navigationBar.barTintColor = AppColor.yellow
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func setUpTabBar() {
        self.tabBarController?.tabBar.tintColor = AppColor.blue
//        self.tabBarController?.tabBar.unselectedItemTintColor = AppColor.gray
        if let feed = self.tabBarController?.tabBar.items?[0] {
            feed.image = TabBarIconImages.feed
            feed.selectedImage = TabBarIconImages.feedSelected
        }
        if let today = self.tabBarController?.tabBar.items?[1] {
            today.image = TabBarIconImages.today
            today.selectedImage = TabBarIconImages.todaySelected
        }
        if let adjusts = self.tabBarController?.tabBar.items?[2] {
            adjusts.image = TabBarIconImages.adjusts
            adjusts.selectedImage = TabBarIconImages.adjustsSelected
        }
        if let profile = self.tabBarController?.tabBar.items?[3] {
            profile.image = TabBarIconImages.profile
            profile.selectedImage = TabBarIconImages.profileSelected
        }
    }
    
    private func setUpCellLayout(_ cell: GreetingTableViewCell) {
        cell.background.layer.masksToBounds = false
        cell.background.layer.shadowColor = UIColor.black.cgColor
        cell.background.layer.shadowOpacity = 0.5
        cell.background.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.background.layer.shadowRadius = 1
        
        cell.background.layer.shadowPath = UIBezierPath(rect: cell.background.bounds).cgPath
        cell.background.layer.shouldRasterize = true
        cell.background.layer.rasterizationScale = UIScreen.main.scale
        
        cell.background.layer.cornerRadius = 20
        cell.background.layer.masksToBounds = false
        cell.background.layer.shadowColor = UIColor.lightGray.cgColor
        cell.background.layer.shadowOpacity = 0.5
        cell.background.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.background.layer.shadowRadius = 20
        
        cell.background.layer.shadowPath = UIBezierPath(rect: cell.background.bounds).cgPath
        cell.background.layer.shouldRasterize = true
        cell.background.layer.rasterizationScale = 1
        
        cell.header.backgroundColor = AppColor.lightBlue
        let headerShape = CAShapeLayer()
        headerShape.bounds = cell.header.frame
        headerShape.position = cell.header.center
        headerShape.path = UIBezierPath(roundedRect: cell.header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 0)).cgPath
        cell.header.layer.mask = headerShape
        
        cell.userPhoto.layer.cornerRadius = cell.userPhoto.frame.size.width/2
        cell.userPhoto.clipsToBounds = true
        
        cell.footer.backgroundColor = AppColor.lightBlue
        let footerShape = CAShapeLayer()
        footerShape.bounds = cell.footer.frame
        footerShape.position = cell.footer.center
        footerShape.path = UIBezierPath(roundedRect: cell.footer.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 0)).cgPath
        cell.footer.layer.mask = footerShape
        
        self.setUpMessage(cell.message!)
    }
    
    private func setUpMessage(_ message: UITextView) {
        message.textContainerInset.left = 13
        message.textContainerInset.right = 13
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.messageTapped))
        message.gestureRecognizers?.append(tapGesture)
    }
    
    private func setUpCell(cell: GreetingTableViewCell, interaction: Interaction) {
        cell.userName.text = interaction.greeting.creator?.name
        cell.title.text = interaction.greeting.type.string
        cell.message.text = interaction.greeting.message
        cell.action.setTitle(!interaction.isRetributed ? ActionKey.retribute : !interaction.isLikedByReceiver ? ActionKey.like : ActionKey.liked, for: .normal)
        cell.action.isEnabled = !interaction.isRetributed || !interaction.isLikedByReceiver
    }
    //MARK: Actions
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "filter", sender: self)
    }
    
    //MARK: Aux funcs
    @objc private func messageTapped(_ sender: UITapGestureRecognizer) {
        if let message = sender.view {
            self.performSegue(withIdentifier: "interactionDetail", sender: message)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            guard let index = self.tableView.indexPath(for: cell)?.last else {
                print("Errow while trying to find row index in table view cells.")
                return
            }
            self.selectedInteraction = self.interactions?[index]
        } else if let text = sender as? UITextView {
            guard let indexString = text.restorationIdentifier, let index = Int(indexString) else {
                print("Errow while trying to find row index in text view restoration identifies.")
                return
            }
            self.selectedInteraction = self.interactions?[index]
        }
        if let greetingViewController = segue.destination as? GreetingViewController {
            greetingViewController.interaction = self.selectedInteraction
        }
    }
 

}
