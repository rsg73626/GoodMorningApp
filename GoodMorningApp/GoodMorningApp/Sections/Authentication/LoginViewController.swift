//
//  LoginViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var loginWithFacebook: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var space: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
//        CodableTests.run()
//        DataManagerTests.run()
        self.setUpNavigationBar()
        self.setUpButtons()
        self.updateButtonsState()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LoginViewController.keyboardWillShow(_:)),
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpFieldsAndButtonsSpace()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .lightContent
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        UIApplication.shared.statusBarStyle = .default
//    }
    
    //MARK: SetUp Functions
    private func setUpNavigationBar() {
        let textAttributes = [NSAttributedStringKey.foregroundColor:AppColor.yellow]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = AppColor.yellow
        self.navigationController?.navigationBar.backgroundColor = AppColor.yellow
        self.navigationController?.navigationBar.tintColor = AppColor.blue
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    private func setUpButtons(){
        self.login.backgroundColor = AppColor.blue
        self.login.tintColor = UIColor.white
        self.login.layer.cornerRadius = 5
        self.loginWithFacebook.backgroundColor = AppColor.blue
        self.loginWithFacebook.tintColor = UIColor.white
        self.loginWithFacebook.layer.cornerRadius = 5
        self.register.backgroundColor = AppColor.blue
        self.register.tintColor = UIColor.white
        self.register.layer.cornerRadius = 5
    }
    
    private func setUpFieldsAndButtonsSpace() {
//        print(self.scrollView.frame.size.height)
//        print(self.scrollView.bounds.size.height)
//        print(self.register.frame.size.height)
//        print(self.register.frame.origin.y)
//        print(self.register.bounds.size.height)
//        print(self.register.bounds.origin.y)
//        let height = self.scrollView.frame.size.height
//        let space = height - (self.register.frame.origin.y + (self.register.frame.size.height/2) + self.bottom.constant)
//        if space > 0 {
//            self.space.constant += space
//            print(self.scrollView.frame.size.height)
//            print(self.scrollView.bounds.size.height)
//            print(self.register.frame.size.height)
//            print(self.register.frame.origin.y)
//            print(self.register.bounds.size.height)
//            print(self.register.bounds.origin.y)
//        }
//        self.register.frame.origin.y += 10
    }
    
    //MARK: UITextFieldDelegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.login.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateButtonsState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.email:
            self.email.resignFirstResponder()
            self.password.becomeFirstResponder()
            break
        default:
            self.password.resignFirstResponder()
        }
        return true
    }
    
    //MARK: Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let email = self.email.text!
        let password = self.password.text!
        
        if !(email.contains("@")) {
            self.showErrorMessage(errorMessage: "Endereço de e-mail inválido.", textField: self.email)
            return
        }
        
        if password.count < 8 {
            self.showErrorMessage(errorMessage: "A senha deve conter no mínimo 8 caracteres.", textField: self.password)
            return
        }
        
        ActivityIndicatorManager.shared.start(to: self)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            ActivityIndicatorManager.shared.stop()
            self.performSegue(withIdentifier: "LoginSuccessful", sender: self)
        }
        
    }
    
    @IBAction func loginWithFacebookButtonTapped(_ sender: UIButton) {
        ActivityIndicatorManager.shared.start(to: self)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            ActivityIndicatorManager.shared.stop()
            self.performSegue(withIdentifier: "LoginSuccessful", sender: self)
        }
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
        self.login.isEnabled = !(self.email.text ?? "").isEmpty
        && !(self.password.text ?? "").isEmpty
    }
    
//    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
//        let userInfo = notification.userInfo ?? [:]
//        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
//        scrollView.contentInset.bottom += adjustmentHeight
//        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
//
//    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0
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
