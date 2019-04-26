//
//  ProfilePresenter.swift
//  Study_Manager
//
//  Created by Dat Truong on 23/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol {
    
    func loadUserInfo()
    
    func logout()

    func performGetUserById(token: String)
    
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    var userService: UserServiceProtocol = UserService()
    var profileService: ProfileServiceProtocol = ProfileService()
    
    init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    func logout() {
        KeyChainUtil.share.setLogOut()
        view?.onLogoutSuccess()
    }
    
    func performGetUserById(token: String) {
        
    }
    
    func loadUserInfo() {
        view?.showLoading()
        self.view?.setUpLoadMyProfile()
        guard let token = KeyChainUtil.share.getToken() else {return}
        profileService.loadProfileData(token: token) {[weak self] (response) in
            self?.view?.hideLoading()
            switch response {
            case.success(let user):
                self?.view?.onLoadDataSuccess(userData: user)
            case .error(let error):
                self?.view?.onLoadDataError(error: error)
            }
        }
    }
    
}
