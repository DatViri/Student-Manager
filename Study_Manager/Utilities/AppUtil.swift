//
//  AppUtil.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

final class AppUtil {
    
    static let shared = AppUtil()
    
    public func formantTimeStamp(isoDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from:date)
        return dateString
    }
    
}
