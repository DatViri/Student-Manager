//
//  AuthResponse.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

struct AuthResponse : Codable{
    var token: String
    var userId: String
}
