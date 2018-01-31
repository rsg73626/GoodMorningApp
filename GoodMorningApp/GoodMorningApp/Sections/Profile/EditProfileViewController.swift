//
//  EditProfileViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 13/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userAbout: UITextView!
    @IBOutlet weak var userContact: UITextField!
    @IBOutlet weak var done: UIBarButtonItem!
    
    //MARK: Properties
    var user: User?
    private let defaultAbout: String = "Digite algo sobre você (esse texto será exibido para os outros usuários somente quando você permitir)."
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPhoto.isUserInteractionEnabled = true
        self.setUpNavigationBar()
        self.setUpUser()
        self.setUpAbout()
        self.setUpContact()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AboutViewController.keyboardWillShow(_:)),
            name: Notification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AboutViewController.keyboardWillHide(_:)),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    //MARK: TextFieldDelegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.done.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateButtons()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.userName:
            self.userName.resignFirstResponder()
            self.userAbout.becomeFirstResponder()
            break
        case self.userEmail:
            self.userEmail.resignFirstResponder()
            self.userContact.becomeFirstResponder()
            break
        case self.userContact:
            self.userContact.resignFirstResponder()
            break
        default:
            print("No text field found!")
        }
        return true
    }
    
    //MARK: TextViewDeleagete functions
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.done.isEnabled = false
        if self.userAbout.text == self.defaultAbout {
            self.userAbout.text = nil
            self.userAbout.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.updateButtons()
        self.updateAbout()
    }
    
    //MARK: ImagePicker functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imagemSelecionada = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Erro ao selecionar imagem: \(info)")
        }
        self.userPhoto.image = imagemSelecionada
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Actions
    @IBAction func userPhotoTapped(_ sender: UITapGestureRecognizer) {
        if self.userName.isFirstResponder { self.userName.resignFirstResponder() }
        if self.userEmail.isFirstResponder { self.userEmail.resignFirstResponder() }
        if self.userAbout.isFirstResponder { self.userAbout.resignFirstResponder() }
        if self.userContact.isFirstResponder { self.userContact.resignFirstResponder() }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alert = UIAlertController(title: "Foto", message: "Escolha uma foto para o seu perfil.", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Tirar uma foto", style: .default, handler: /*{_ in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }*/nil)
        let galeryAction = UIAlertAction(title: "Escolher da galeria", style: .default, handler : /*{_ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }*/nil)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(galeryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        let name = self.userName.text!
        let email = self.userEmail.text!
        if name.count < 2{
            self.showErrorMessage(errorMessage: "O campo nome deve ter no mímino 2 caracteres.", text: self.userName)
            return
        }
        if !email.contains("@") {
            self.showErrorMessage(errorMessage: "Insira um email válido.", text: self.userEmail)
            return
        }
        ActivityIndicatorManager.shared.start(to: self)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            ActivityIndicatorManager.shared.stop()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: SetUp functions
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = AppColor.yellow
        self.navigationController?.navigationBar.tintColor = AppColor.blue
    }
    
    private func setUpUser() {
        if let user = self.user {
            userName.text = user.name!
            userEmail.text = user.email!
            userAbout.text = user.about
            if let contact = self.user?.contacts?.first {
                self.userContact.text = contact.content
            }
        }
    }
    
    private func setUpAbout() {
        self.userAbout.layer.borderWidth = 0.3
        self.userAbout.layer.borderColor = UIColor.lightGray.cgColor
        self.userAbout.layer.cornerRadius = 5
        self.userAbout.textContainerInset.left = 13
        self.userAbout.textContainerInset.right = 13
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okButton: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.aboutOkButtonTapped))
        toolbar.setItems([flexibleSpace, okButton], animated: false)
        self.userAbout.inputAccessoryView = toolbar
    }
    
    private func setUpContact() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okButton: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(self.contactOkButtonTapped))
        toolbar.setItems([flexibleSpace, okButton], animated: false)
        self.userContact.inputAccessoryView = toolbar
    }
    
    //MARK: Update functions
    private func updateAbout() {
        if self.userAbout.text.isEmpty || self.userAbout.text.replacingOccurrences(of: " ", with: "").isEmpty || self.userAbout.text == self.defaultAbout {
            let lightGray = UIColor.lightGray.withAlphaComponent(0.7)
            self.userAbout.text = self.defaultAbout
            self.userAbout.textColor = lightGray
        }
    }
    
    private func updateButtons() {
        if !(self.userName.text?.replacingOccurrences(of: " ", with: "").isEmpty)! && !(self.userEmail.text?.replacingOccurrences(of: " ", with: "").isEmpty)! {
            self.done.isEnabled = true
        } else {
            self.done.isEnabled = false
        }
    }
    
    //MARK: Aux functions
    private func showErrorMessage(errorMessage: String, text: UIView){
        let alert = UIAlertController(title: "Erro", message: errorMessage, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("OK", comment: "Dados errados"),
                style: .default,
                handler: {_ in text.becomeFirstResponder()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
        
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print("keyboard will show!")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        print("keyboard will hide!")
        scrollView.contentInset.bottom = 0
    }
    
    @objc private func aboutOkButtonTapped() {
        self.userAbout.resignFirstResponder()
        self.userEmail.becomeFirstResponder()
    }
    
    @objc private func contactOkButtonTapped() {
        self.userContact.resignFirstResponder()
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
