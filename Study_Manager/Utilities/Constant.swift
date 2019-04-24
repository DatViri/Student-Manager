//
//  Constant.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit

class URLConst {
    static let BASE_URL = "https://stmanager-app.herokuapp.com"
    static let USER_PATH = "/api/users/"
    static let AUTH_PATH = "/auth/signin"
    static let USER_ME_PATH = "/api/users/me"
    
    static let COURSE_PATH = "/api/courses/"
    static let COURSE_FILTER = "/api/courses/filter/"
}

extension UIColor {
    static let appDarkColor = UIColor(red: 70.0 / 255.0, green: 65.0 / 255.0, blue: 125.0 / 255.0, alpha: 1.0)         //#46417d
    static let appDefaultColor = UIColor(red: 77.0 / 255.0, green: 71.0 / 255.0, blue: 136.0 / 255.0, alpha: 1.0)         // #4d4788
    static let appLightColor = UIColor(red: 124.0 / 255.0, green: 114.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)         // #7c72b8
    static let appLighterColor = UIColor(red: 192.0 / 255.0, green: 190.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0)         // #C0BEDD
    static let appPinkWhiteColor = UIColor(red: 235.0 / 255.0, green: 234.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)         // #EBEAF4
    static let errorColor = UIColor(red: 255.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)  //FF6666
}

