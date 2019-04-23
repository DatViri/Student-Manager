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
    
    func updateUser(username: String, phoneNumber: String, avatarPath: String?, email: String)
    
    func upLoadPicture(imgData: Data?)
    
}


