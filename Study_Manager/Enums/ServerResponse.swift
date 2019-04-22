//
//  ServerResponse.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

enum ServerResponse<T>{
    case success(T)
    case error(error: AppError)
}
