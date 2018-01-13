//
//  AdjustsTableViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class AdjustsTableViewController: UITableViewController {
    
    //MARK: Outlets
    @IBOutlet weak var morning: UISwitch!
    @IBOutlet weak var morningFrom: UIDatePicker!
    @IBOutlet weak var morningTo: UIDatePicker!
    
    @IBOutlet weak var afternoon: UISwitch!
    @IBOutlet weak var afternoonFrom: UIDatePicker!
    @IBOutlet weak var afternoonTo: UIDatePicker!
    
    @IBOutlet weak var evening: UISwitch!
    @IBOutlet weak var eveningFrom: UIDatePicker!
    @IBOutlet weak var eveningTo: UIDatePicker!
    
    @IBOutlet weak var dawn: UISwitch!
    @IBOutlet weak var dawnFrom: UIDatePicker!
    @IBOutlet weak var dawnTo: UIDatePicker!
    
    @IBOutlet weak var notificationRadius: UISlider!
    @IBOutlet weak var radius: UILabel!
    
    //MARK: Properties
    let preferences: PreferenceManager = PreferenceManager.shared
    
    //MARK: Types
    private struct PickerIdentifier{
        static let morningFrom = "morningFrom"
        static let morningTo = "morningTo"
        static let afternoonFrom = "afternoonFrom"
        static let afternoonTo = "afternoonTo"
        static let eveningFrom = "eveningFrom"
        static let eveningTo = "eveningTo"
        static let dawnFrom = "dawnFrom"
        static let dawnTo = "dawnTo"
    }
    
    private struct SwitchIdentifier{
        static let morning = "morning"
        static let afternoon = "afternoon"
        static let evening = "evening"
        static let dawn = "dawn"
    }
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpGoodMorning()
        self.setUpGoodAfternoon()
        self.setUpGoodEvening()
        self.setUpGoodDawn()
        
        self.notificationRadius.setValue(Float(self.preferences.radius), animated: false)
        self.updateRadiusLabel(to: self.preferences.radius)
    }
    
    //MARK: Set up functions
    private func setUpGoodMorning(){
        self.morning.isOn = self.preferences.isGoodMorningActive
        self.morningFrom.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.morningFrom.setDate(self.preferences.goodMorningInterval.from, animated: false)
        self.morningTo.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.morningTo.setDate(self.preferences.goodMorningInterval.to, animated: false)
        self.updateGoodMorning()
    }
    
    private func setUpGoodAfternoon(){
        self.afternoon.isOn = self.preferences.isGoodAfternoonActive
        self.afternoonFrom.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.afternoonFrom.setDate(self.preferences.goodAfternoonInterval.from, animated: false)
        self.afternoonTo.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.afternoonTo.setDate(self.preferences.goodAfternoonInterval.to, animated: false)
        self.updateGoodAfternoon()
    }
    
    private func setUpGoodEvening(){
        self.evening.isOn = self.preferences.isGoodEveningActive
        self.eveningFrom.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.eveningFrom.setDate(self.preferences.goodEveningInterval.from, animated: false)
        self.eveningTo.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.eveningTo.setDate(self.preferences.goodEveningInterval.to, animated: false)
        self.updateGoodEvening()
    }
    
    private func setUpGoodDawn(){
        self.dawn.isOn = self.preferences.isGoodDawnActive
        self.dawnFrom.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.dawnFrom.setDate(self.preferences.goodDawnInterval.from, animated: false)
        self.dawnTo.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.dawnTo.setDate(self.preferences.goodDawnInterval.to, animated: false)
        self.updateGoodDawn()
    }
    
    //MARK: Update functions
    private func updateGoodMorning(){
        self.morningFrom.isEnabled = self.morning.isOn
        self.morningTo.isEnabled = self.morning.isOn
    }
    
    private func updateGoodAfternoon(){
        self.afternoonFrom.isEnabled = self.afternoon.isOn
        self.afternoonTo.isEnabled = self.afternoon.isOn
    }
    
    private func updateGoodEvening(){
        self.eveningFrom.isEnabled = self.evening.isOn
        self.eveningTo.isEnabled = self.evening.isOn
    }
    
    private func updateGoodDawn(){
        self.dawnFrom.isEnabled = self.dawn.isOn
        self.dawnTo.isEnabled = self.dawn.isOn
    }
    
    private func updateRadiusLabel(to value: Int){
        self.radius.text = "\(value) km"
    }
    
    //MARK: Actions
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        print("\(sender.restorationIdentifier) Date Picker changed!")
        let date = sender.date
        switch sender.restorationIdentifier ?? ""{
        case PickerIdentifier.morningFrom:
            self.preferences.changeGoodMorningInterval(key: .From, to: date)
            break
        case PickerIdentifier.morningTo:
            self.preferences.changeGoodMorningInterval(key: .To, to: date)
            break
        case PickerIdentifier.afternoonFrom:
            self.preferences.changeGoodAfternoonIntervar(key: .From, to: date)
            break
        case PickerIdentifier.afternoonTo:
            self.preferences.changeGoodAfternoonIntervar(key: .To, to: date)
            break
        case PickerIdentifier.eveningFrom:
            self.preferences.changeGoodEveningInterval(key: .From, to: date)
            break
        case PickerIdentifier.eveningTo:
            self.preferences.changeGoodEveningInterval(key: .To, to: date)
            break
        case PickerIdentifier.dawnFrom:
            self.preferences.changeGoodDawnInterval(key: .From, to: date)
            break
        case PickerIdentifier.dawnTo:
            self.preferences.changeGoodDawnInterval(key: .To, to: date)
            break
        default:
            print("No Date Picker Identifier found!")
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        switch sender.restorationIdentifier ?? "" {
        case SwitchIdentifier.morning:
            self.preferences.changeIsGoodMorningActive()
            self.updateGoodMorning()
            break
        case SwitchIdentifier.afternoon:
            self.preferences.changeIsGoodAfternoonActive()
            self.updateGoodAfternoon()
            break
        case SwitchIdentifier.evening:
            self.preferences.changeIsGoodEveningActive()
            self.updateGoodEvening()
            break
        case SwitchIdentifier.dawn:
            self.preferences.changeIsGoodDawnActive()
            self.updateGoodDawn()
            break
        default:
            print("No Switch Identifier found!")
        }
    }
    
    @IBAction func radiusChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.preferences.changeRadius(to: currentValue)
        self.updateRadiusLabel(to: currentValue)
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
