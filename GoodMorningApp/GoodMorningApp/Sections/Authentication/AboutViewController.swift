//
//  AboutViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var about: UITextView!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Properties
    var user: User?
    private var isDefaultAbout: Bool = true
    private let defaultAbout: String = "Digite algo sobre você (esse texto será exibido para os outros usuários somente quando você permitir)."
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.profile.isUserInteractionEnabled = true
        self.setUpAbout()
        self.setUpContact()
        self.setUpButton()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: SetUp functions
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.tintColor = AppColor.blue
    }
    
    private func setUpAbout() {
        let lightGray = UIColor.lightGray.withAlphaComponent(0.7)
        self.about.textColor = lightGray
        self.about.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.about.layer.borderWidth = 0.3
        self.about.layer.borderColor = UIColor.lightGray.cgColor
        self.about.layer.cornerRadius = 5
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okButton: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(self.aboutOkButtonTapped))
        toolbar.setItems([flexibleSpace, okButton], animated: false)
        self.about.inputAccessoryView = toolbar
    }
    
    private func setUpContact() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okButton: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(self.contactOkButtonTapped))
        toolbar.setItems([flexibleSpace, okButton], animated: false)
        self.contact.inputAccessoryView = toolbar
    }
    
    private func setUpButton() {
        self.done.backgroundColor = AppColor.blue
        self.done.tintColor = UIColor.white
        self.done.layer.cornerRadius = 5
    }
    
    //MARK: UITextViewDelegate functions
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.done.isEnabled = false
        if self.isDefaultAbout {
            self.about.text = nil
            self.about.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let about = self.about.text, !about.replacingOccurrences(of: " ", with: "").isEmpty {
            self.isDefaultAbout = false
        } else {
            self.isDefaultAbout = true
            self.about.textColor = UIColor.lightGray
            self.about.text = self.defaultAbout
        }
        self.updateButtonsState()
    }
    
    //MARK: UITextFieldDelegate functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.done.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateButtonsState()
    }
    
    //MARK: ImagePicker functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imagemSelecionada = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Erro ao selecionar imagem: \(info)")
        }
        self.profile.image = imagemSelecionada
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func skipButtonTapped(_ sender: UIBarButtonItem) {
        ActivityIndicatorManager.shared.start(to: self)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            ActivityIndicatorManager.shared.stop()
            self.performSegue(withIdentifier: "RegisterSuccessful", sender: self)
        }
    }
    
    @IBAction func profilePhotoTapped(_ sender: UITapGestureRecognizer) {
        if self.about.isFirstResponder { self.about.resignFirstResponder() }
        if self.contact.isFirstResponder { self.contact.resignFirstResponder() }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alert = UIAlertController(title: "Foto", message: "Escolha uma foto para o seu perfil.", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Tirar uma foto", style: .default, handler: {_ in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        })
        let galeryAction = UIAlertAction(title: "Escolher da galeria", style: .default, handler : {_ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(galeryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let about = self.about.text!
        let contact = self.contact.text!
        
        if !self.isDefaultAbout && about.replacingOccurrences(of: " ", with: "").count < 5 {
            self.showErrorMessage(errorMessage: self.defaultAbout, text: self.about)
            return
        }
        
        if contact.replacingOccurrences(of: " ", with: "").count < 8 {
            self.showErrorMessage(errorMessage: "Entre com um contato válido.", text: self.contact)
            return
        }
        
        //TODO: implement photo
        self.user?.about = about
        self.user?.contacts?.append(Contact(content: contact, type: .Cellphone))
        
        ActivityIndicatorManager.shared.start(to: self)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            ActivityIndicatorManager.shared.stop()
            self.performSegue(withIdentifier: "RegisterSuccessful", sender: self)
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
    
    private func updateButtonsState(){
        self.done.isEnabled = !(self.about.text ?? "").isEmpty
            && !self.isDefaultAbout && !(self.contact.text ?? "").isEmpty
    }
    
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
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
        self.about.resignFirstResponder()
        self.contact.becomeFirstResponder()
    }
    
    @objc private func contactOkButtonTapped() {
        self.contact.resignFirstResponder()
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
