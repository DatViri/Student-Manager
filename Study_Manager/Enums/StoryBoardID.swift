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
    case categoryVC = "categoryScreen"
    case paymentVC = "paymentScreen"
    case editProfileVC = "editProfileScreen"
    case courseDetailVC = "courseDetailScreen"
    case enrolledCourseVC = "enrollCoursesScreen"
    
    var identifier: String {
        return self.rawValue
    }
}

enum AppTableCell: String {
    case tableCell = "tableCell"
    case enrolledCoursesCell = "enrolledCoursesCell"
    case voucherCell = "voucherCell"
    case profileCell = "profileCell"
    case notificationCell = "notificationCell"
    case leaderBoardCell = "leaderBoardCell"
    
    var identifier: String {
        return self.rawValue
    }
}
