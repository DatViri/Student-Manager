//
//  UserDefaultUtil.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {}

extension UserDefaultsProtocol{
    
    private var logInKey: String {
        return "logInKey"
    }
    
    private var onBoardingKey: String {
        return "onBoardingKey"
    }
    
    
    private var userNameKey: String {
        return "userNameKey"
    }
    
    private var userDefault: UserDefaults {
        return UserDefaults.standard
    }
    
    func setUserName(username: String) {
        userDefault.set(username, forKey: userNameKey)
    }
    
    func getUserName() -> String? {
        return userDefault.string(forKey: userNameKey)
    }
    
    func setLogInSate() {
        userDefault.set(true, forKey: logInKey)
    }
    
    func getLogInState() -> Bool {
        return userDefault.bool(forKey: logInKey)
    }
    
    
    func setLogOut() {
        userDefault.set(false, forKey: logInKey)
    }
    
    func setSeeOnboardingState() {
        userDefault.set(true, forKey: onBoardingKey)
    }
    
    func getSeeOnboardingState() -> Bool {
        return userDefault.bool(forKey: onBoardingKey)
    }
    
}
