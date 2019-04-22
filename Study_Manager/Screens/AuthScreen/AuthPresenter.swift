//
//  AuthPresenter.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

//LOGIC
protocol AuthPresenterProtocol {
    
    func performLogin(userName: String, password: String)
    
    func performRegister(userName: String, password: String, email: String, phoneNumber: String, age: String, school: String)
    
    func checkToken()
    
    func changeAccount()
    
}

class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: AuthViewProtocol?
    var authService: AuthServiceProtocol = AuthService()
    
    
    init(view: AuthViewProtocol) {
        self.view = view
    }
    
    func performLogin(userName: String, password: String) {
        if userName.isEmpty || password.isEmpty {
            view?.onShowError(error: .emptyField)
            view?.hideLoading()
        } else {
            view?.showLoading()
            authService.login(username: userName, password: password, completion: { [weak self] response in
                switch response {
                case .success(let authResponse):
                    //Save the token and userId
                    KeyChainUtil.share.setToken(token: authResponse.token)
                    KeyChainUtil.share.setUserId(userId: authResponse.userId)
                    KeyChainUtil.share.setLogInSate()
                    KeyChainUtil.share.setUserName(username: userName)
                    self?.view?.onSuccess()
                    self?.view?.hideLoading()
                case .error(let error):
                    self?.view?.onShowError(error: error)
                    self?.view?.hideLoading()
                }
            })
            
        }
    }
    
    
    func performRegister(userName: String, password: String, email: String, phoneNumber: String, age: String, school: String) {
        if userName.isEmpty || password.isEmpty || email.isEmpty || phoneNumber.isEmpty {
            view?.onShowError(error: .emptyField)
            view?.hideLoading()
        } else {
            view?.showLoading()
            authService.register(username: userName, password: password, email: email, phoneNumber: phoneNumber, age: age, school: school, completion: { [weak self] response in
                switch response {
                case .success(let authResponse):
                    //Save the token and userId
                    KeyChainUtil.share.setToken(token: authResponse.token)
                    KeyChainUtil.share.setUserId(userId: authResponse.userId)
                    KeyChainUtil.share.setLogInSate()
                    KeyChainUtil.share.setUserName(username: userName)
                    self?.view?.onSuccess()
                    self?.view?.hideLoading()
                case .error(let error):
                    self?.view?.onShowError(error: error)
                    self?.view?.hideLoading()
                }
            })
        }
    }
    
    func checkToken() {
        if KeyChainUtil.share.hasToken() {
            guard let userName = KeyChainUtil.share.getUserName() else { return }
            self.view?.setUserName(userName: userName)
            view?.showChangeAccountBtn()
        } else {
            view?.hideChangeAccountBtn()
        }
    }
    
    func changeAccount() {
        KeyChainUtil.share.removeToken()
        KeyChainUtil.share.removeUserId()
        self.view?.onChangeAccountSuccess()
        view?.hideChangeAccountBtn()
    }
    
}
