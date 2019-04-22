//
//  Response.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    var status: Int
    var data: T?
    var description: String?
    var code: Int?
}
