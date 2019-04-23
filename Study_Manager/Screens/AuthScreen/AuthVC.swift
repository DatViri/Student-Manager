//
//  AuthVC.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit

protocol AuthViewProtocol: class {
    
    func showLoading()
    
    func hideLoading()
    
    func onShowError(error: AppError)
    
    func onSuccess()
    
    func setUserName(userName: String)
    
    func onChangeAccountSuccess()
    
    func showChangeAccountBtn()
    
    func hideChangeAccountBtn()
}

class AuthVC: UIViewController, AuthViewProtocol {
    
    // MARK: - Outlet
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var authStatusLbl: UILabel!
    
    @IBOutlet weak var changeAccountBtn: UIButton!
    @IBOutlet weak var performSignUpBtn: UIButton!
    @IBOutlet weak var authSwitchBtn: UIButton!
    
    @IBOutlet weak var passwordStack: UIStackView!
    @IBOutlet weak var usernameStack: UIStackView!
    @IBOutlet weak var emailStack: UIStackView!
    @IBOutlet weak var phoneNumberStack: UIStackView!
    @IBOutlet weak var ageStack: UIStackView!
    @IBOutlet weak var schoolStack: UIStackView!

    //MARK: - Properties
    var presenter: AuthPresenterProtocol?
    var isSignIn = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = AuthPresenter(view: self)
        delegateTextField()
        presenter?.checkToken()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AuthVC.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Action
    @IBAction func authSwitchBtnWasPressed(_ sender: Any){
        if isSignIn {
            //Register clicked
            isSignIn = false
            authStatusLbl.text = "SIGN UP"
            
            hideChangeAccountBtn()
            usernameTextField.text = ""
            passwordTextField.text = ""
            authSwitchBtn.setTitle("Already have an account?", for: .normal)
            
            UIView.transition(with: self.emailStack, duration: 0.5, options: .transitionCurlDown, animations: {
                self.emailStack.isHidden = false
            }, completion: nil)
            
            UIView.transition(with: self.phoneNumberStack, duration: 0.5, options: .transitionCurlDown, animations: {
                self.phoneNumberStack.isHidden = false
            }, completion: nil)
            
            UIView.transition(with: self.ageStack, duration: 0.5, options: .transitionCurlDown, animations: {
                self.ageStack.isHidden = false
            }, completion: nil)
            
            UIView.transition(with: self.schoolStack, duration: 0.5, options: .transitionCurlDown, animations: {
                self.schoolStack.isHidden = false
            }, completion: nil)
            
        } else {
            //Sign in clicked
            isSignIn = true
            authStatusLbl.text = "SIGN IN"
            authSwitchBtn.setTitle("Don't have an account?", for: .normal)
            presenter?.checkToken()
            
            UIView.transition(with: self.emailStack, duration: 0.5, options: .transitionCurlUp, animations: {
                self.emailStack.isHidden = true
            }, completion: nil)
            
            UIView.transition(with: self.phoneNumberStack, duration: 0.5, options: .transitionCurlUp, animations: {
                self.phoneNumberStack.isHidden = true
            }, completion: nil)
            
            UIView.transition(with: self.ageStack, duration: 0.5, options: .transitionCurlDown, animations: {
                self.ageStack.isHidden = true
            }, completion: nil)
            
            UIView.transition(with: self.schoolStack, duration: 0.5, options: .transitionCurlDown, animations: {
                self.schoolStack.isHidden = true
            }, completion: nil)
        }
    }
    
    @IBAction func performSignUp(_ sender: Any){
        if (isSignIn) {
            let username = usernameTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            presenter?.performLogin(userName: username , password: password)
        } else {
            let username = usernameTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let phoneNumber = phonenumberTextField.text ?? ""
            let age = ageTextField.text ?? ""
            let school = schoolTextField.text ?? ""
            presenter?.performRegister(userName: username, password: password, email: email, phoneNumber: phoneNumber, age: age, school: school)
        }
    }
    
    @IBAction func changeAccountBtnWasPressed(_ sender: Any){
        presenter?.changeAccount()
    }

    //MARK: - Protocol
    func onShowError(error: AppError) {
        errorLabel.isHidden = false
        errorLabel.text = error.description
    }
    
    func onSuccess() {
        goToMainVC()
    }
    
    func showLoading() {
        showLoadingIndicator()
    }
    
    func hideLoading() {
        hideLoadingIndicator()
    }
    
    func setUserName(userName: String) {
        usernameTextField.text = userName
        //changeAccountBtn.isHidden = false
    }
    
    func onChangeAccountSuccess() {
        usernameTextField.text = ""
    }
    
    func delegateTextField() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        phonenumberTextField.delegate = self
        ageTextField.delegate = self
        schoolTextField.delegate = self
    }
    
    func showChangeAccountBtn() {
        UIView.transition(with: self.changeAccountBtn, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.changeAccountBtn.isHidden = false
        }, completion: nil)
    }
    
    func hideChangeAccountBtn() {
        UIView.transition(with: self.changeAccountBtn, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.changeAccountBtn.isHidden = true
        }, completion: nil)
    }
    
    func goToMainVC() {
        UIApplication.shared.statusBarStyle = .lightContent
        guard let mainVC = storyboard?.instantiateViewController(withIdentifier: AppStoryBoard.mainVC.identifier) else {return}
        present(mainVC, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension AuthVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.text = ""
    }
}

extension AuthVC{
    func setupUI() {
        authStatusLbl.text = "SIGN IN"
        errorLabel.text = "Error"
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        emailTextField.placeholder = "Email"
        phonenumberTextField.placeholder = "Phone Number"
        ageTextField.placeholder = "Age"
        schoolTextField.placeholder = "School"
        changeAccountBtn.setTitle("Sign in with another account", for: .normal)
        performSignUpBtn.setTitle("Confirm", for: .normal)
        authSwitchBtn.setTitle("Don't have an account?", for: .normal)
    }
}
