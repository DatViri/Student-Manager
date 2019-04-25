//
//  CourseDetailPresenter.swift
//  Study_Manager
//
//  Created by Dat Truong on 25/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

protocol CourseDetailPresenterProtocol {
    func performGetCourse(courseId: String)
}

class CourseDetailPresenter: CourseDetailPresenterProtocol {
    var courseService: CourseServiceProtocol = CourseService()
    
    weak var view: CourseDetailVCProtocol?
    
    init(view: CourseDetailVCProtocol) {
        self.view = view
    }
    
    func performGetCourse(courseId: String) {
        view?.showLoading()
        courseService.getCourseById(courseId: courseId) {[weak self] (response) in
            self?.view?.hideLoading()
            switch response {
            case .success(let course):
                self?.view?.onGetCourseSuccess(course: course)
            case .error(let error):
                self?.view?.onShowError(error: error)
            }
        }
    }
}
