//
//  EditProfileVC.swift
//  Study_Manager
//
//  Created by Dat Truong on 23/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit
import Foundation

protocol EditProfileViewProtocol: class {
    
    func onLoadDataSuccess(userData: User)
    
    func onShowError(error: AppError)
    
    func onUpdateUserSuccess(userData: User)
    
    func showLoading()
    
    func hideLoading()
    
}

class EditProfileVC: UIViewController, EditProfileViewProtocol {

    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var schoolLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    //MARK: - Properties
    var presenter: EditProfilePresenterProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.appDarkColor
        setupUI()
        presenter = EditProfilePresenter(view: self)
        presenter?.loadUserInfo()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileVC.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Protocols
    
    func onLoadDataSuccess(userData: User) {
        updateUI(userData: userData)
    }
    
    func onShowError(error: AppError) {
        showError(message: error.description)
    }
    
    func onUpdateUserSuccess(userData: User) {
        updateUI(userData: userData)
        dismiss(animated: true, completion: nil)
    }
    
    func showLoading() {
        showLoadingIndicator()
    }
    
    func hideLoading() {
        hideLoadingIndicator()
    }
    
    //MARK: - Functions
    func updateUI(userData: User) {
        nameTextField.text = userData.username
        emailTextField.text = userData.email
        ageTextField.text = userData.age
        schoolTextField.text = userData.school
        phoneTextField.text = userData.phoneNumber
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupUI() {
        titleLbl.text = "Edit Profile"
        titleLbl.textColor = UIColor.white
        nameLbl.text = "Name edit:"
        emailLbl.text = "Email edit:"
        phoneLbl.text = "Phone Number edit:"
        ageLbl.text = "Age edit:"
        schoolLbl.text = "School edit:"
        nameTextField.placeholder = "Edit Name"
        emailTextField.placeholder = "Edit Email"
        phoneTextField.placeholder = "Edit Phone"
        ageTextField.placeholder = "Edit age"
        schoolTextField.placeholder = "Edit school"
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    //MARK: Actions
    
    @IBAction func saveBtnWasPressed(_ sender: Any) {
        
            let username = nameTextField.text ?? ""
            let phoneNumber = phoneTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let age = ageTextField.text ?? ""
            let school = schoolTextField.text ?? ""
            presenter?.updateUser(username: username, phoneNumber: phoneNumber, email: email, age: age, school: school)
    }
    
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
