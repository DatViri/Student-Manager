//
//  EnrolledCoursesCell.swift
//  Study_Manager
//
//  Created by Dat Truong on 26/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit

class EnrolledCoursesCell: UITableViewCell {

    @IBOutlet weak var courseNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!

    func config(enrolledCourses: CourseDetail) {
        courseNameLbl.text = enrolledCourses.courseName
        courseNameLbl.textColor = UIColor.appDefaultColor
        timeLbl.text = AppUtil.shared.formantTimeStamp(isoDate: enrolledCourses.time)
    }
    
}
