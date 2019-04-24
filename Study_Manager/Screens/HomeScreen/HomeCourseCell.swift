//
//  HomeCourseCell.swift
//  Study_Manager
//
//  Created by Dat Truong on 24/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation
import UIKit

class HomeCourseCell: UITableViewCell{
    
    
    @IBOutlet weak var courseNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    
    func config(courseHome: CourseDetail) {
        courseNameLbl.text = courseHome.courseName
        
        let price = courseHome.price
        if price == 0 {
            priceLbl.text = "FREE"
        } else {
            priceLbl.text = String(courseHome.price)
        }
        
    }
    
    //MARK: Helper
}

