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
    @IBOutlet weak var morningHeader: UIView!
    @IBOutlet weak var morningTitle: UILabel!
    @IBOutlet weak var morningInterval: UILabel!
    @IBOutlet weak var morning: UISwitch!
    @IBOutlet weak var morningInfo: UIButton!
    @IBOutlet weak var morningFrom: UIDatePicker!
    
    @IBOutlet weak var afeternoonHeader: UIView!
    @IBOutlet weak var afternoonTitle: UILabel!
    @IBOutlet weak var afternoonInterval: UILabel!
    @IBOutlet weak var afternoon: UISwitch!
    @IBOutlet weak var afternoonInfo: UIButton!
    @IBOutlet weak var afternoonFrom: UIDatePicker!
    
    @IBOutlet weak var eveningHeader: UIView!
    @IBOutlet weak var eveningTitle: UILabel!
    @IBOutlet weak var eveningInterval: UILabel!
    @IBOutlet weak var evening: UISwitch!
    @IBOutlet weak var eveningInfo: UIButton!
    @IBOutlet weak var eveningFrom: UIDatePicker!
    
    @IBOutlet weak var dawnHeader: UIView!
    @IBOutlet weak var dawnTitle: UILabel!
    @IBOutlet weak var dawnInterval: UILabel!
    @IBOutlet weak var dawn: UISwitch!
    @IBOutlet weak var dawnInfo: UIButton!
    @IBOutlet weak var dawnFrom: UIDatePicker!
    
    @IBOutlet weak var notificationRadius: UISlider!
    @IBOutlet weak var radius: UILabel!
    
    @IBOutlet weak var renanPhoto: UIImageView!
    @IBOutlet weak var luizPhoto: UIImageView!
    
    //MARK: Properties
    let preferences: PreferenceManager = PreferenceManager.shared
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setUpGoodMorning()
        self.setUpGoodAfternoon()
        self.setUpGoodEvening()
        self.setUpGoodDawn()
        self.setUpNotificationRadius()
        self.setUpDevelopers()
    }
    
    //MARK: UITableView functions
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 40.0
        }
        return 0.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = AppColor.lightBlue
        let label = UILabel()
        label.frame = CGRect(x: 16, y: (40-20.5)/2, width: 200, height: 20.5)
        label.text = section == 1 ? "Raio de notificação" : "Desenvolvedor"
        label.textColor = UIColor.white
        view.addSubview(label)
        return view
    }
    
    //MARK: Set up functions
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = AppColor.yellow
        self.navigationController?.navigationBar.tintColor = AppColor.blue
    }
    
    private func setUpGoodMorning() {
        self.morningHeader.backgroundColor = AppColor.lightBlue
        self.morning.onTintColor = AppColor.blue
        self.morning.isOn = self.preferences.isGoodMorningActive
        self.morningFrom.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.morningFrom.setDate(self.preferences.goodMorningInterval.from, animated: false)
        
        self.updateGoodMorning()
    }
    
    private func setUpGoodAfternoon(){
        self.afeternoonHeader.backgroundColor = AppColor.lightBlue
        self.afternoon.onTintColor = AppColor.blue
        self.afternoon.isOn = self.preferences.isGoodAfternoonActive
        self.afternoonFrom.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.afternoonFrom.setDate(self.preferences.goodAfternoonInterval.from, animated: false)
        self.updateGoodAfternoon()
    }
    
    private func setUpGoodEvening(){
        self.eveningHeader.backgroundColor = AppColor.lightBlue
        self.evening.onTintColor = AppColor.blue
        self.evening.isOn = self.preferences.isGoodEveningActive
        self.eveningFrom.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.eveningFrom.setDate(self.preferences.goodEveningInterval.from, animated: false)
        self.updateGoodEvening()
    }
    
    private func setUpGoodDawn(){
        self.dawnHeader.backgroundColor = AppColor.lightBlue
        self.dawn.onTintColor = AppColor.blue
        self.dawn.isOn = self.preferences.isGoodDawnActive
        self.dawnFrom.timeZone = TimeZone.init(secondsFromGMT: 0)
        self.dawnFrom.setDate(self.preferences.goodDawnInterval.from, animated: false)
        self.updateGoodDawn()
    }
    
    private func setUpNotificationRadius() {
        self.notificationRadius.setValue(Float(self.preferences.radius), animated: false)
        self.updateRadiusLabel(to: self.preferences.radius)
    }
    
    private func setUpDevelopers() {
        [renanPhoto, luizPhoto].forEach {photo in photo?.layer.cornerRadius = (photo?.frame.size.width)!/2; photo?.clipsToBounds = true}
    }
    
    //MARK: Update functions
    private func updateGoodMorning(){
        self.morningFrom.isEnabled = self.morning.isOn
        self.morningInfo.isEnabled = self.morning.isOn
        
    }
    
    private func updateGoodAfternoon(){
        self.afternoonFrom.isEnabled = self.afternoon.isOn
        self.afternoonInfo.isEnabled = self.afternoon.isOn
    }
    
    private func updateGoodEvening(){
        self.eveningFrom.isEnabled = self.evening.isOn
        self.eveningInfo.isEnabled = self.evening.isOn
    }
    
    private func updateGoodDawn(){
        self.dawnFrom.isEnabled = self.dawn.isOn
        self.dawnInfo.isEnabled = self.dawn.isOn
    }
    
    private func updateGoodMorningInterval() {
        let from = Parser.shared.dateToString(self.morningFrom.date, format: "HH:mm") ?? ""
        let to = Parser.shared.dateToString(self.afternoonFrom.date, format: "HH:mm") ?? ""
        self.morningInterval.text = "\(from) - \(to)"
    }
    
    private func updateGoodAfternoonInterval() {
        let from = Parser.shared.dateToString(self.afternoonFrom.date, format: "HH:mm") ?? ""
        let to = Parser.shared.dateToString(self.eveningFrom.date, format: "HH:mm") ?? ""
        self.afternoonInterval.text = "\(from) - \(to)"
    }
    
    private func updateGoodEveningInterval() {
        let from = Parser.shared.dateToString(self.eveningFrom.date, format: "HH:mm") ?? ""
        let to = Parser.shared.dateToString(self.dawnFrom.date, format: "HH:mm") ?? ""
        self.eveningInterval.text = "\(from) - \(to)"
    }
    
    private func updateGoodDawnInterval() {
        let from = Parser.shared.dateToString(self.dawnFrom.date, format: "HH:mm") ?? ""
        let to = Parser.shared.dateToString(self.morningFrom.date, format: "HH:mm") ?? ""
        self.dawnInterval.text = "\(from) - \(to)"
    }
    
    private func updateRadiusLabel(to value: Int){
        self.notificationRadius.minimumTrackTintColor = AppColor.blue
        self.radius.text = "\(value) km"
    }
    
    //MARK: Actions
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let date = sender.date
        switch sender {
        case self.morningFrom:
            self.preferences.changeGoodMorningInterval(key: .From, to: date)
            self.updateGoodMorningInterval()
            break
        case self.afternoonFrom:
            self.preferences.changeGoodAfternoonIntervar(key: .From, to: date)
            self.updateGoodAfternoonInterval()
            break
        case self.eveningFrom:
            self.preferences.changeGoodEveningInterval(key: .From, to: date)
            self.updateGoodEveningInterval()
            break
        case self.dawnFrom:
            self.preferences.changeGoodDawnInterval(key: .From, to: date)
            self.updateGoodDawnInterval()
            break
        default:
            print("No Date Picker  found!")
        }
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        switch sender {
        case self.morning:
            self.preferences.changeIsGoodMorningActive()
            self.updateGoodMorning()
            break
        case self.afternoon:
            self.preferences.changeIsGoodAfternoonActive()
            self.updateGoodAfternoon()
            break
        case self.evening:
            self.preferences.changeIsGoodEveningActive()
            self.updateGoodEvening()
            break
        case self.dawn:
            self.preferences.changeIsGoodDawnActive()
            self.updateGoodDawn()
            break
        default:
            print("No Switch found!")
        }
    }
    
    @IBAction func radiusChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        self.preferences.changeRadius(to: currentValue)
        self.updateRadiusLabel(to: currentValue)
    }
    
    @IBAction func restoreAdjustsButtonTapped(_ sender: Any) {
        let message = "Tem certeza que deseja restaurar os ajustes? Isso fará os ajustes voltarem para o seu estado original e sua configuração atual será perdida."
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let restoreAction = UIAlertAction(title: "Restaurar", style: .destructive, handler: { action in
            ActivityIndicatorManager.shared.start(to: self)
            self.morning.setOn(true, animated: false)
            self.switchChanged(self.morning)
            self.afternoon.setOn(true, animated: false)
            self.switchChanged(self.afternoon)
            self.evening.setOn(true, animated: false)
            self.switchChanged(self.evening)
            self.dawn.setOn(true, animated: false)
            self.switchChanged(self.dawn)
            self.morningFrom.setDate(Parser.shared.stringToDate("06:01", format: "HH:mm")!, animated: false)
            self.datePickerChanged(self.morningFrom)
            self.afternoonFrom.setDate(Parser.shared.stringToDate("12:01", format: "HH:mm")!, animated: false)
            self.datePickerChanged(self.afternoonFrom)
            self.eveningFrom.setDate(Parser.shared.stringToDate("18:01", format: "HH:mm")!, animated: false)
            self.datePickerChanged(self.eveningFrom)
            self.dawnFrom.setDate(Parser.shared.stringToDate("00:01", format: "HH:mm")!, animated: false)
            self.datePickerChanged(self.dawnFrom)
            self.notificationRadius.setValue(5, animated: false)
            self.radiusChanged(self.notificationRadius)
            ActivityIndicatorManager.shared.stop()
        })
        
        let alert = UIAlertController(title: "Restaurar ajustes", message: message, preferredStyle: .alert)
        alert.addAction(restoreAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        let message = "Todas os cumprimentos do tipo \(sender.restorationIdentifier ?? "") serão enviados e recebidos a partir deste horário, até o inicio do horário do próximo cumprimento."
        let alert = UIAlertController(title: "Horário de cumprimento", message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Entendi", comment: "Informações sobre o horário de cumprimento."),
                style: .default,
                handler: nil))
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
