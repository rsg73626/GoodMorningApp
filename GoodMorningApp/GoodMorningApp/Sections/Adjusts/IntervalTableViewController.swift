//
//  IntervalTableViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 05/02/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class IntervalTableViewController: UITableViewController {
    
    //MARK: Outlets
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var done: UIBarButtonItem!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var intervalMessage: UILabel!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var fromMessage: UILabel!
    
    //MARK: Properties
    private let titles = ["Intervalo atual", "A partir de"]
    var greeting: GreetingType?
    var from: Date?
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Table view functions
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = self.view.frame.size.width
        let header = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        header.backgroundColor = AppColor.lightBlue
        let title = UILabel(frame: CGRect(x: 16, y: (40-21)/2, width: width-32, height: 21))
        title.text = self.titles[section]
        title.textColor = UIColor.white
        header.addSubview(title)
        return header
    }
    
    //MARK: SetUp functions
    private func setUpBarButtonItems() {
        for b in [self.cancel, self.done] {
            b?.tintColor = AppColor.blue
        }
    }
    
    private func setUpMessages() {
        for m in [self.intervalMessage, self.fromMessage] {
            m?.textColor = AppColor.gray
        }
    }
    
    //MARK: Actions
    @IBAction func barButtonItemTapped(_ sender: UIBarButtonItem) {
        switch sender {
        case self.cancel:
            self.dismiss(animated: true, completion: nil)
            break
        case self.done:
            self.dismiss(animated: true, completion: nil)
            break
        default:
            print("No bar button item found!")
        }
    }
    

}
