//
//  Course.swift
//  Study_Manager
//
//  Created by Dat Truong on 24/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

enum Category: String {
    case business
    case art
    case history
    case health
    case nature
    case languages
    case law
    case literature
    case science
    case free
    case all
    
    var description: String {
        return self.rawValue
    }
}

struct CourseDetail: Codable{
    var time: String
    var _id: String
    var courseName: String
    var description: String
    var price: Int
    var category: String
    var imgPath: String
}

struct Course: Codable {
    var time: String
    var _id: String
    var courseName: String
    var description: String
    var price: Int
    var category: String
    var imgPath: String
}
