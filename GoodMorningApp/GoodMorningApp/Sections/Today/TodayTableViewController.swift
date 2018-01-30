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
    @IBOutlet weak var morningEdit: UIButton!
    @IBOutlet weak var morningClear: UIButton!
    
    @IBOutlet weak var afternoonMessage: UITextView!
    @IBOutlet weak var afternoonEdit: UIButton!
    @IBOutlet weak var afternoonClear: UIButton!
    
    @IBOutlet weak var eveningMessage: UITextView!
    @IBOutlet weak var eveningEdit: UIButton!
    @IBOutlet weak var eveningClear: UIButton!
    
    @IBOutlet weak var dawnMessage: UITextView!
    @IBOutlet weak var dawnEdit: UIButton!
    @IBOutlet weak var dawnClear: UIButton!
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setUpTextViews()
        self.setUpButtons()
    }
    
    //MARK: UITableView functions
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let view = UIView()
            view.backgroundColor = AppColor.lightBlue
            let label = UILabel()
            label.frame = CGRect(x: 16, y: (40-20.5)/2, width: 200, height: 20.5)
            label.text = section == 0 ? "Bom dia" : section == 1 ? "Boa tarde" : section == 2 ? "Boa noite" : "Boa madrugada"
            label.textColor = UIColor.white
            view.addSubview(label)
            return view
    }
    
    //MARK: Actions
    @IBAction func editButtonTapped(_ sender: UIButton) {
        switch sender {
        case self.morningEdit:
            self.morningMessage.becomeFirstResponder()
            break;
        case self.afternoonEdit:
            self.afternoonMessage.becomeFirstResponder()
            break;
        case self.eveningEdit:
            self.eveningMessage.becomeFirstResponder()
            break;
        case self.dawnEdit:
            self.dawnMessage.becomeFirstResponder()
            break;
        default:
            print("No button found!")
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        let textView: UITextView = sender == self.morningClear ? self.morningMessage : sender == self.afternoonClear ? self.afternoonMessage : sender == self.eveningClear ? self.eveningMessage : self.dawnMessage
        let message = "Tem certeza que deseja limpar sua mensagem personalizada?"
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let clearAction = UIAlertAction(title: "Limpar", style: .destructive, handler: { action in
            sender.isEnabled = false
            textView.text = nil
            textView.becomeFirstResponder()
        })
        
        let alert = UIAlertController(title: "Limpar mensagem", message: message, preferredStyle: .alert)
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: SetUp functions
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = AppColor.yellow
        self.navigationController?.navigationBar.tintColor = AppColor.blue
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setUpTextViews() {
        let lightGray = UIColor.lightGray.withAlphaComponent(0.7)
        self.morningMessage.layer.borderWidth = 0.3
        self.morningMessage.layer.borderColor = UIColor.lightGray.cgColor
        self.morningMessage.layer.cornerRadius = 5
        self.morningMessage.textContainerInset.left = 13
        self.morningMessage.textContainerInset.right = 13
        
        self.afternoonMessage.layer.borderWidth = 0.3
        self.afternoonMessage.layer.borderColor = UIColor.lightGray.cgColor
        self.afternoonMessage.layer.cornerRadius = 5
        self.afternoonMessage.textContainerInset.left = 13
        self.afternoonMessage.textContainerInset.right = 13
        
        self.eveningMessage.layer.borderWidth = 0.3
        self.eveningMessage.layer.borderColor = UIColor.lightGray.cgColor
        self.eveningMessage.layer.cornerRadius = 5
        self.eveningMessage.textContainerInset.left = 13
        self.eveningMessage.textContainerInset.right = 13
        
        self.dawnMessage.layer.borderWidth = 0.3
        self.dawnMessage.layer.borderColor = UIColor.lightGray.cgColor
        self.dawnMessage.layer.cornerRadius = 5
        self.dawnMessage.textContainerInset.left = 13
        self.dawnMessage.textContainerInset.right = 13
    }
    
    private func setUpButtons() {
        self.morningEdit.backgroundColor = AppColor.blue
        self.morningEdit.tintColor = UIColor.white
        self.morningEdit.layer.cornerRadius = 5
        self.morningClear.backgroundColor = AppColor.blue
        self.morningClear.tintColor = UIColor.white
        self.morningClear.layer.cornerRadius = 5
        
        self.afternoonEdit.backgroundColor = AppColor.blue
        self.afternoonEdit.tintColor = UIColor.white
        self.afternoonEdit.layer.cornerRadius = 5
        self.afternoonClear.backgroundColor = AppColor.blue
        self.afternoonClear.tintColor = UIColor.white
        self.afternoonClear.layer.cornerRadius = 5
        
        self.eveningEdit.backgroundColor = AppColor.blue
        self.eveningEdit.tintColor = UIColor.white
        self.eveningEdit.layer.cornerRadius = 5
        self.eveningClear.backgroundColor = AppColor.blue
        self.eveningClear.tintColor = UIColor.white
        self.eveningClear.layer.cornerRadius = 5
        
        self.dawnEdit.backgroundColor = AppColor.blue
        self.dawnEdit.tintColor = UIColor.white
        self.dawnEdit.layer.cornerRadius = 5
        self.dawnClear.backgroundColor = AppColor.blue
        self.dawnClear.tintColor = UIColor.white
        self.dawnClear.layer.cornerRadius = 5
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
