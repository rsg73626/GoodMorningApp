//
//  TodayTableViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class TodayTableViewController: UITableViewController {
    
    //MARK: Outlets
    @IBOutlet weak var morningMessage: UITextView!
    @IBOutlet weak var morningDone: UIButton!
    @IBOutlet weak var morningClear: UIButton!
    
    @IBOutlet weak var afternoonDone: UIButton!
    @IBOutlet weak var afternoonMessage: UITextView!
    @IBOutlet weak var afternoonClear: UIButton!
    
    @IBOutlet weak var eveningMessage: UITextView!
    @IBOutlet weak var eveningDone: UIButton!
    @IBOutlet weak var eveningClear: UIButton!
    
    @IBOutlet weak var dawnMessage: UITextView!
    @IBOutlet weak var dawnDone: UIButton!
    @IBOutlet weak var dawnClear: UIButton!
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction func doneTapped(_ sender: Any) {
    }
    
    @IBAction func clearTapped(_ sender: Any) {
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
