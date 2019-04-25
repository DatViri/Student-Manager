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
    
    func performEnrollCourse(courseId: String, source: String, completion: @escaping (User?, AppError?) -> Void)
    
    func getMe()
}

class CourseDetailPresenter: CourseDetailPresenterProtocol {
    var courseService: CourseServiceProtocol = CourseService()
    var enrollService: EnrollServiceProtocol = EnrollService()
    var userService: UserServiceProtocol = UserService()

    
    weak var view: CourseDetailVCProtocol?
    
    init(view: CourseDetailVCProtocol) {
        self.view = view
    }
    
    func performEnrollCourse(courseId: String, source: String, completion: @escaping (User?, AppError?) -> Void){
        view?.showLoading()
        guard let token = KeyChainUtil.share.getToken() else {print("Error get token"); return}
        enrollService.createEnroll(token: token, courseId: courseId, source: source, completion: { [weak self] response in
            switch response {
            case .success(let enroll):
                print("perform enroll success")
                self?.view?.onEnrollCourseSuccess(enroll: enroll)
                self?.view?.hideLoading()
            case .error(let error):
                self?.view?.onShowError(error: error)
                self?.view?.hideLoading()
            }
        })
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
    
    func getMe() {
        guard let token = KeyChainUtil.share.getToken() else {return}
        self.view?.showLoading()
        userService.getUserMe(token: token) { [weak self] (response) in
            self?.view?.hideLoading()
            switch response {
            case .success(let user):
                self?.view?.onGetMeSuccess(user: user)
            case .error(let error):
                self?.view?.onGetMeError(error: error)
            }
        }
    }
}
