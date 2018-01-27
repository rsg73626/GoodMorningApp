//
//  FilterViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 21/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: Properties
    private let actions = ["Nenhuma", "Retribuiu", "Curtiu"]
    private let times = ["Hoje", "Essa semana", "Esse mês"]
    
    //MARK: Outlets
    @IBOutlet weak var typeHeader: UIView!
    @IBOutlet weak var morning: UISwitch!
    @IBOutlet weak var afternoon: UISwitch!
    @IBOutlet weak var evening: UISwitch!
    @IBOutlet weak var dawn: UISwitch!
    
    @IBOutlet weak var actionHeader: UIView!
    @IBOutlet weak var action: UIPickerView!
    
    @IBOutlet weak var timeHeader: UIView!
    @IBOutlet weak var time: UIPickerView!
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpHeaders()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: PickerView Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    //MARK: PickerView Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.restorationIdentifier == "action"{
            return self.actions[row]
        }else{
            return self.times[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.restorationIdentifier == "action"{
            
        }else{
            
        }
    }
    
    //MARK: Actions
    @IBAction func switchChanged(_ sender: UISwitch) {
        switch sender {
        case self.morning:
            
            break
        case self.afternoon:
            
            break
        case self.evening:
            
            break
        case self.dawn:
            
            break
        default:
            print("No Switch Identifier found!")
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: SetUp functions
    private func setUpHeaders() {
        self.typeHeader.backgroundColor = AppColor.blue
        self.actionHeader.backgroundColor = AppColor.blue
        self.timeHeader.backgroundColor = AppColor.blue
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
