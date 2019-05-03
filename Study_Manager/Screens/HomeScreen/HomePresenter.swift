//
//  HomePresenter.swift
//  Study_Manager
//
//  Created by Dat Truong on 24/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol {
    
    func performGetAvailableCourses()
    
    func performGetCoursesByCategory(category: Category)
    
    func filterContentForSearchText(_ searchText: String, courses: [CourseDetail])
}

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeVCProtocol?
    var courseService: CourseServiceProtocol = CourseService()
    
    init(view: HomeVCProtocol) {
        self.view = view
    }
    
    
    func performGetAvailableCourses() {
        view?.showLoading()
        courseService.getAvailableCourses(completion: { [weak self] response in
            switch response {
            case .success(let homeCourses):
                //print("This is a presenter response: \(homeCourses)")
                self?.view?.onGetAvailableCoursesSuccess(homeCourses: homeCourses)
                self?.view?.hideLoading()
            case .error(let error):
                self?.view?.onShowError(error: error)
                self?.view?.hideLoading()
            }
        })
    }
    
    func performGetCoursesByCategory(category: Category) {
        view?.showLoading()
        courseService.getCoursesByCategory(category: category, completion: { [weak self] response in
            switch response {
            case .success(let homeCourses):
                //print("This is a presenter response: \(homeCourses)")
                self?.view?.onGetAvailableCoursesSuccess(homeCourses: homeCourses)
                self?.view?.hideLoading()
            case .error(let error):
                self?.view?.onShowError(error: error)
                self?.view?.hideLoading()
            }
        })
    }
    
    func filterContentForSearchText(_ searchText: String, courses: [CourseDetail]) {
        let filteredCourses = courses.filter({( course : CourseDetail) -> Bool in
            return course.courseName.lowercased().contains(searchText.lowercased())
        })
        
        if filteredCourses.count > 0 && !searchText.isEmpty {
            view?.onShowFilteredCourses(homeCourses: filteredCourses)
        } else if searchText.isEmpty {
            view?.onShowFilteredCourses(homeCourses: courses)
        } else {
            view?.onShowFilteringNoResult()
        }
    }
    
}


