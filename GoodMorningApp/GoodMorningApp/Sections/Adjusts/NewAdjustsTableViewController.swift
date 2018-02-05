//
//  NewAdjustsTableViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 04/02/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class NewAdjustsTableViewController: UITableViewController {
    
    //MARK: Outlets
    @IBOutlet weak var restore: UIBarButtonItem!
    @IBOutlet weak var morning: UISwitch!
    @IBOutlet weak var afternoon: UISwitch!
    @IBOutlet weak var evening: UISwitch!
    @IBOutlet weak var dawn: UISwitch!
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var renan: UIImageView!
    
    //MARK: Properties
    private let titles = ["Bom dia", "Boa tarde", "Boa noite", "Boa madrugada", "Raio de notificação", "Desenvolvedor"]
    private var selectedGreeting: GreetingType?
    private var selectedFrom: Date?
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpRestoreButton()
        self.setUpSwitches()
        self.setUpNotificationRadius()
        self.setUpDeveloper()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view functions
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = self.view.frame.size.width
        let header = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        header.backgroundColor = AppColor.lightBlue
        let title = UILabel(frame: CGRect(x: 16, y: (40-21)/2, width: (width/2)-16, height: 21))
        title.text = self.titles[section]
        title.textColor = UIColor.white
        header.addSubview(title)
        if section < 4 {
            let interval = UIButton(frame: CGRect(x: width/2, y: 7, width: (self.tableView.frame.size.width/2)-16, height: 30))
            interval.restorationIdentifier = "\(section)"
            interval.setTitleColor(AppColor.blue, for: .normal)
            interval.setTitle("00:00 - 00:00", for: .normal)
            interval.contentHorizontalAlignment = .right
            interval.addTarget(self, action: #selector(self.intervalButtonTapped(_:)), for: UIControlEvents.touchUpInside)
            header.addSubview(interval)
        }
        return header
    }
    
    //MARK: SetUp functions
    private func setUpRestoreButton() {
        self.restore.tintColor = AppColor.blue
    }
    
    private func setUpSwitches() {
        for s in [self.morning, self.afternoon, self.evening, self.dawn] {
            s?.onTintColor = AppColor.blue
        }
    }
    
    private func setUpNotificationRadius() {
        self.radiusSlider.minimumTrackTintColor = AppColor.blue
        
    }
    
    private func setUpDeveloper() {
        self.renan.layer.cornerRadius = (self.renan.frame.size.width)/2
        self.renan.clipsToBounds = true
    }
    
    //MARK: Actions
    @IBAction func restoreButtonTapped(_ sender: UIBarButtonItem) {
        print("*** Restore button tapped! ***")
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        switch sender {
        case self.morning:
            print("*** Morning switch! ***")
            break
        case self.afternoon:
            print("*** Afternoon switch! ***")
            break
        case self.evening:
            print("*** Evening switch! ***")
            break
        case self.dawn:
            print("*** Dawn switch! ***")
            break
        default:
            print("No switch found!")
        }
    }
    
    @IBAction func radiusSliderChanged(_ sender: UISlider) {
        let value = sender.value
        if value < 1000 {
            self.radiusLabel.text = "\(value) m"
        } else {
            self.radiusLabel.text = "1 km"
        }
    }
    
    @objc private func intervalButtonTapped(_ button: UIButton) {
        let section = Int(button.restorationIdentifier ?? "0")!
        self.selectedGreeting = GreetingType.list[section]
        self.selectedFrom = Date()
        self.performSegue(withIdentifier: "ShowGreetingInterval", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IntervalTableViewController {
            destination.greeting = self.selectedGreeting
            destination.from = self.selectedFrom
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
