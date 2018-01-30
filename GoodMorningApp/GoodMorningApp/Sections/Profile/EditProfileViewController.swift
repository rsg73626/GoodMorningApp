//
//  EditProfileViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 13/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userAbout: UITextView!
    @IBOutlet weak var userContact: UITextField!
    
    //MARK: Properties
    var user: User?
    
    //MARK: Life cicle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userPhoto.isUserInteractionEnabled = true
        self.setUpNavigationBar()
        self.setUpUser()
        self.setUpAbout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: SetUp functions
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = AppColor.yellow
        self.navigationController?.navigationBar.tintColor = AppColor.blue
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setUpUser() {
        self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.width/2
        self.userPhoto.clipsToBounds = true
        if let user = self.user {
            userName.text = user.name!
            userEmail.text = user.email!
            userAbout.text = user.about!
            if let contact = self.user?.contacts?.first{
                self.userContact.text = contact.content
            }else{
                self.userContact.text = "Insira um contato."
            }
        }
    }
    
    private func setUpAbout() {
        let lightGray = UIColor.lightGray.withAlphaComponent(0.7)
        self.userAbout.layer.borderWidth = 0.3
        self.userAbout.layer.borderColor = UIColor.lightGray.cgColor
        self.userAbout.layer.cornerRadius = 5
        self.userAbout.textContainerInset.left = 13
        self.userAbout.textContainerInset.right = 13
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
