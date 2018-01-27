//
//  FeedTableViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "greeting", for: indexPath) as! GreetingTableViewCell
        self.setUpCell(cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 344
    }
    
    
    //MARK: SetUp functions
    private func setUpTabBar() {
        self.tabBarController?.tabBar.tintColor = AppColor.blue
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
    }
    private func setUpCell(_ cell: GreetingTableViewCell) {
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
        
        cell.footer.backgroundColor = AppColor.lightBlue
        let footerShape = CAShapeLayer()
        footerShape.bounds = cell.footer.frame
        footerShape.position = cell.footer.center
        footerShape.path = UIBezierPath(roundedRect: cell.footer.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 20, height: 0)).cgPath
        cell.footer.layer.mask = footerShape
        
        self.setUpMessage(cell.message!)
    }
    
    private func setUpMessage(_ message: UITextView) {
//        let lightGray = UIColor.lightGray.withAlphaComponent(0.7)
//        message.layer.borderWidth = 0.3
//        message.layer.borderColor = UIColor.lightGray.cgColor
//        message.layer.cornerRadius = 5
        message.textContainerInset.left = 16
        message.textContainerInset.right = 16
    }
    
    //MARK: Actions
    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "filter", sender: self)
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
