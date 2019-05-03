//
//  EditProfilePresenter.swift
//  Study_Manager
//
//  Created by Dat Truong on 23/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

protocol EditProfilePresenterProtocol {
    
    func loadUserInfo()
    
    func performGetUserById()
    
    func updateUser(username: String, phoneNumber: String, email: String, age: String, school: String)
    
}

class EditProfilePresenter: EditProfilePresenterProtocol {
    
    
    weak var view: EditProfileViewProtocol?
    var userService: UserServiceProtocol = UserService()
    var profileService: ProfileServiceProtocol = ProfileService()
    
    init(view: EditProfileViewProtocol) {
        self.view = view
    }
    
    func loadUserInfo() {
        view?.showLoading()
        guard let token = KeyChainUtil.share.getToken() else {return}
        profileService.loadProfileData(token: token) { (response) in
            switch response{
            case.success(let user):
                self.view?.hideLoading()
                self.view?.onLoadDataSuccess(userData: user)
            case .error(let error):
                self.view?.hideLoading()
                self.view?.onShowError(error: error)
            }
        }
    }
    
    func updateUser(username: String, phoneNumber: String, email: String, age: String, school: String) {
        
        if username.isEmpty  || email.isEmpty || phoneNumber.isEmpty || age.isEmpty || school.isEmpty  {
            self.view?.hideLoading()
            self.view?.onShowError(error: AppError.emptyField)
            return
        }
        
        if age.count > 2 {
            self.view?.hideLoading()
            self.view?.onShowError(error: AppError.invalidAge)
            return
        }
        
        if phoneNumber.count != 10{
            self.view?.hideLoading()
            self.view?.onShowError(error: AppError.invalidPhoneNumber)
            return
        }
        
        
        guard let token = KeyChainUtil.share.getToken() else {return}
        profileService.updateProfileData(token: token, username: username, email: email, phoneNumber: phoneNumber, age: age, school: school) { (response) in
            switch response{
            case.success(let user):
                self.view?.hideLoading()
                self.view?.onUpdateUserSuccess(userData: user)
            case.error(let error):
                self.view?.hideLoading()
                self.view?.onShowError(error: error)
            }
        }
    }
    
    func performGetUserById() {
        
    }
    
}

