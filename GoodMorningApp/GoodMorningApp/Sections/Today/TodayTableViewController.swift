//
//  TodayTableViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class TodayTableViewController: UITableViewController, UITextViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var morningMessage: UITextView!
    @IBOutlet weak var afternoonMessage: UITextView!
    @IBOutlet weak var eveningMessage: UITextView!
    @IBOutlet weak var dawnMessage: UITextView!
    
    //MARK: Properties
    private var selectedTextView: UITextView?
    private let placeHolderMessage = "Entre com uma mensagem personalizada de "
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setUpTextViews()
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
    
    //MARK: UITextView functions
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == self.placeHolderMessage + "\(textView.restorationIdentifier!)." {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        self.selectedTextView = textView
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.updateTextView(textView)
    }
    
    //MARK: SetUp functions
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = AppColor.yellow
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func setUpTextViews() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.okButtonTapped))
        let clearButton = UIBarButtonItem(title: "Limpar", style: .plain, target: self, action: #selector(clearButtonTapped))
        toolbar.setItems([clearButton, flexibleSpace, okButton], animated: false)
        for message in [self.morningMessage, self.afternoonMessage, self.eveningMessage, self.dawnMessage] {
            message?.layer.borderWidth = 0.3
            message?.layer.borderColor = UIColor.lightGray.cgColor
            message?.layer.cornerRadius = 5
            message?.textContainerInset.left = 13
            message?.textContainerInset.right = 13
            message?.inputAccessoryView = toolbar
        }
    }
    
    //MARK: Update functions
    private func updateTextView(_ textView: UITextView) {
        if textView.text.replacingOccurrences(of: " ", with: "").isEmpty {
            let lightGray = UIColor.lightGray.withAlphaComponent(0.7)
            textView.textColor = lightGray
            textView.text = self.placeHolderMessage + "\(textView.restorationIdentifier!)."
        }
    }
    
    //MARK: Aux functions
    @objc func okButtonTapped() {
        self.selectedTextView?.resignFirstResponder()
        self.selectedTextView = nil
    }
    
    @objc func clearButtonTapped() {
        let message = "Tem certeza que deseja limpar sua mensagem personalizada?"
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let clearAction = UIAlertAction(title: "Limpar", style: .destructive, handler: { action in
            self.selectedTextView?.text = nil
        })
        let alert = UIAlertController(title: "Limpar mensagem", message: message, preferredStyle: .alert)
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}
