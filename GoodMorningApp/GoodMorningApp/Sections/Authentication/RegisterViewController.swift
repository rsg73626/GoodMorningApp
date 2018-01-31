//
//  RegisterViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var registerWithFacebook: UIButton!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    //MARK: Properties
    private var user: User!
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpButtons()
        self.updateButtonsState()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RegisterViewController.keyboardWillShow(_:)),
            name: Notification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LoginViewController.keyboardWillHide(_:)),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: SetUp functions
    
    private func setUpButtons() {
        self.done.backgroundColor = AppColor.blue
        self.done.tintColor = UIColor.white
        self.done.layer.cornerRadius = 5
        self.registerWithFacebook.backgroundColor = AppColor.blue
        self.registerWithFacebook.tintColor = UIColor.white
        self.registerWithFacebook.layer.cornerRadius = 5
    }
    
    //MARK: UITextFieldDelegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.done.isEnabled = false
        //MARK: Tentativa de ajutstar o conteúdo ao teclado
        if textField == self.name {
//            print("Begin editing name!")
//            self.scrollView.contentInset.bottom += 432
//            self.scrollView.scrollIndicatorInsets.bottom += 432
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateButtonsState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.name:
            self.email.becomeFirstResponder()
        case self.email:
            self.password.becomeFirstResponder()
        case self.password:
            self.confirmPassword.becomeFirstResponder()
        default:
            self.confirmPassword.resignFirstResponder()
        }
        return true
    }
    
    //MARK: Actions
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let name = self.name.text!
        let email = self.email.text!
        let password = self.password.text!
        let confirmPassword = self.confirmPassword.text!
        
        if name.count < 2{
            self.showErrorMessage(errorMessage: "O campo nome deve ter no mímino 2 caracteres.", textField: self.name)
            return
        }
        
        if !email.contains("@") {
            self.showErrorMessage(errorMessage: "Insira um email válido.", textField: self.email)
            return
        }
        
        if password.count < 8{
            self.showErrorMessage(errorMessage: "Sua senha deve ter no mínimo 8 caracteres.", textField: self.password)
            return
        }
        
        if password != confirmPassword{
            self.showErrorMessage(errorMessage: "Os campos \"senha\" e \"confirmação de senha\" são diferentes.", textField: self.password)
            return
        }
        
        self.user = User(name: name, email: email, password: password)
    }
    
    @IBAction func registerWithFacebookButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Aux functions
    private func showErrorMessage(errorMessage: String, textField: UITextField){
        let alert = UIAlertController(title: "Erro", message: errorMessage, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("OK", comment: "Dados errados"),
                style: .default,
                handler: {_ in textField.becomeFirstResponder()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updateButtonsState(){
        self.done.isEnabled = !(self.name.text ?? "").isEmpty
            && !(self.email.text ?? "").isEmpty
            && !(self.password.text ?? "").isEmpty
            && !(self.confirmPassword.text ?? "").isEmpty
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let about = segue.destination as? AboutViewController {
            about.user = self.user
        }
    }

}
