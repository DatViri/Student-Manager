//
//  EnrolledCoursesPresenter.swift
//  Study_Manager
//
//  Created by Dat Truong on 26/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

protocol EnrolledCoursesPresenterProtocol {
    
    func performGetEnrolledCourses(userId: String)
    
    func loadUserInfo()
    
}

class EnrolledCoursesPresenter: EnrolledCoursesPresenterProtocol {
    
    weak var view: EnrolledCoursesVCProtocol?
    var enrollService: EnrollServiceProtocol = EnrollService()
    var profileService: ProfileServiceProtocol = ProfileService()
    
    init(view: EnrolledCoursesVCProtocol) {
        self.view = view
    }
    
    func performGetEnrolledCourses(userId: String){
        view?.showLoading()
        enrollService.getCoursesEnrollByMe(userId: userId, completion: { [weak self] response in
            switch response {
            case .success(let enrolledCourses):
                print("perform enroll success")
                self?.view?.onGetEnrolledCoursesSuccess(enrolledCourses: enrolledCourses)
                self?.view?.hideLoading()
            case .error(let error):
                self?.view?.onShowError(error: error)
                self?.view?.hideLoading()
            }
        })
    }
    
    func loadUserInfo() {
        view?.showLoading()
        guard let token = KeyChainUtil.share.getToken() else {return}
        profileService.loadProfileData(token: token) { (response) in
            switch response{
            case.success(let user):
                self.view?.hideLoading()
                self.view?.onLoadDataSuccess(userData: user)
            case .error(let error):
                self.view?.hideLoading()
                self.view?.onShowError(error: error)
            }
        }
    }
    
}
