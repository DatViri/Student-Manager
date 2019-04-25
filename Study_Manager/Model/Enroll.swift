//
//  Enroll.swift
//  Study_Manager
//
//  Created by Dat Truong on 25/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

struct Enroll: Codable {
    var _id: String
    var courseId: String
    var userId: String
    var time: String
}

struct EnrollDetail: Codable {
    var _id: String
    var course: Course
    var user: User
    var time: String
}
