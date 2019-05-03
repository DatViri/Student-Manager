//
//  AppError.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

//list all the error here
enum AppError: Error {
    
    //Global
    case noInternetConnection
    case emptyField
    
    //Server Error
    case emptyItem
    case emptyImage
    case invalidPhoneNumber
    case invalidEmail
    case invalidAge
    case usernameIsUsed
    case phoneNumberIsUsed
    case usernameDoesNotExist
    case incorrectPassword
    case cannotFindItem
    case cannotRequestPoint
    case duplicateCourse
    case unknown
    
}

extension AppError {
    
    init(code: Int, status: Int) {
        switch status {
        case 400:
            switch code {
            case 8:
                self =  .invalidEmail
            case 9:
                self = .invalidPhoneNumber
            case 10:
                self = .invalidAge
            case 14:
                self = .usernameIsUsed
            case 16:
                self = .phoneNumberIsUsed
            case 17:
                self = .usernameDoesNotExist
            case 0:
                self = .duplicateCourse
            default:
                self = .unknown
            }
        case 401:
            switch code {
            case 18:
                self = .incorrectPassword
            default:
                self = .unknown
            }
        case 404:
            switch code {
            case 1:
                self = .cannotFindItem
            default:
                self = .unknown
            }
        case 500:
            self = .unknown
        default:
            self = .unknown
        }
    }
    
    var description: String {
        switch self {
        case .emptyField:
            return "Field should not be empty"
        case .emptyImage:
            return "Image should not be empty"
        case .noInternetConnection:
            return "No internet connection"
        case .invalidPhoneNumber:
            return "Phone number must have 10 numbers"
        case.invalidAge:
            return "Age must have 2 numbers"
        case .invalidEmail:
            return "Invalid email"
        case .usernameIsUsed:
            return "This username has already been used"
        case .phoneNumberIsUsed:
            return "This phone number has already been used"
        case .usernameDoesNotExist:
            return "Username does not exist"
        case .incorrectPassword:
            return "Password is not correct"
        case .cannotFindItem:
            return "Item has been deleted"
        case .cannotRequestPoint:
            return "Could not request point"
        case .duplicateCourse:
            return "You already enrolled for this course"
        case .unknown:
            return "Unknown error"
        default:
            return "Unknown Error"
        }
    }
}
