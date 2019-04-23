//
//  User.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

struct User: Codable {
    var _id: String
    var username: String
    var email: String
    var phoneNumber: Int
    var age: String
    var school: String
}
