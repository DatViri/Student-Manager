//
//  StoryBoardID.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

enum AppStoryBoard: String{
    case mainVC = "tabbarScreen"
    case authVC = "authScreen"
    case onBoardingVC = "onboardingScreen"
    case profileVC = "profileScreen"
    case mapVC = "mapScreen"
    case homeVC = "homeScreen"
    case categoryVC = "categoryScreen"
    case paymentVC = "paymentScreen"
    case voucherVC = "voucherScreen"
    case receiptVC = "receiptScreen"
    case editProfileVC = "editProfileScreen"
    case notificationVC = "notificationScreen"
    case leaderBoardVC = "leaderBoardScreen"
    case itemDetailVC = "itemDetailScreen"
    case postVC = "postScreen"
    
    var identifier: String {
        return self.rawValue
    }
}

enum AppTableCell: String {
    case paymentCell = "paymentCell"
    case foldingCell = "FoldingCell"
    case voucherCell = "voucherCell"
    case profileCell = "profileCell"
    case notificationCell = "notificationCell"
    case leaderBoardCell = "leaderBoardCell"
    
    var identifier: String {
        return self.rawValue
    }
}
