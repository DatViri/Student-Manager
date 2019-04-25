//
//  CourseService.swift
//  Study_Manager
//
//  Created by Dat Truong on 24/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation
import Alamofire

protocol CourseServiceProtocol {
    func getAvailableCourses(completion: @escaping (ServerResponse<[CourseDetail]>) -> Void)
    
    func getCoursesByCategory(category: Category, completion: @escaping (ServerResponse<[CourseDetail]>) -> Void)
    
    func getCourseById(courseId: String, completion: @escaping (ServerResponse<CourseDetail>) -> Void)
}

class CourseService: CourseServiceProtocol {
    
    let jsonDecoder = JSONDecoder()
    
    func getAvailableCourses(completion: @escaping (ServerResponse<[CourseDetail]>) -> Void) {
        Alamofire.request(
            URL(string: URLConst.BASE_URL + URLConst.COURSE_PATH)!,
            method: .get)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let serverResponse = try self.jsonDecoder.decode(Response<[CourseDetail]>.self, from: response.data!)
                        let status = serverResponse.status
                        switch status {
                        case 200:
                            guard let homeCourses = serverResponse.data else {debugPrint("Error loading courses"); return}
                            completion(ServerResponse.success(homeCourses))
                        default:
                            guard let code = serverResponse.code else {print("Error: server code"); return}
                            let appError = AppError(code: code, status: status)
                            completion(ServerResponse.error(error: appError))
                            debugPrint("Error loading homeCourses")
                        }
                    } catch(let error) {
                        debugPrint(error)
                        return
                    }
                case .failure(let error):
                    print(error)
                    completion(ServerResponse.error(error: AppError.noInternetConnection))
                    print("failure")
                }
        }
    }
    
    func getCoursesByCategory(category: Category, completion: @escaping (ServerResponse<[CourseDetail]>) -> Void) {
        var parameters: Parameters
        
        switch category {
        case .free:
            parameters = ["price": "0"]
        default:
            parameters = ["category": category]
        }
        Alamofire.request(
            URL(string: URLConst.BASE_URL + URLConst.COURSE_FILTER)!,
            method: .get,
            parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let serverResponse = try self.jsonDecoder.decode(Response<[CourseDetail]>.self, from: response.data!)
                        let status = serverResponse.status
                        switch status {
                        case 200:
                            guard let homeCourses = serverResponse.data else {debugPrint("Error loading courses"); return}
                            homeCourses.forEach({ (course) in
                                print(course.category)
                            })
                            completion(ServerResponse.success(homeCourses))
                        default:
                            guard let code = serverResponse.code else {print("Error: server code"); return}
                            let appError = AppError(code: code, status: status)
                            completion(ServerResponse.error(error: appError))
                            debugPrint("default case: Error loading homeCourses")
                        }
                    } catch(let error) {
                        debugPrint(error)
                        return
                    }
                case .failure(let error):
                    print(error)
                    completion(ServerResponse.error(error: AppError.noInternetConnection))
                    print("failure")
                }
        }
    }
    
    func getCourseById(courseId: String, completion: @escaping (ServerResponse<CourseDetail>) -> Void) {
        Alamofire.request(
            URL(string: URLConst.BASE_URL + URLConst.COURSE_PATH + courseId)!,
            method: .get)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let serverResponse = try self.jsonDecoder.decode(Response<CourseDetail>.self, from: response.data!)
                        let status = serverResponse.status
                        switch status {
                        case 200:
                            guard let homeCourses = serverResponse.data else {debugPrint("Error loading course"); return}
                            completion(ServerResponse.success(homeCourses))
                        default:
                            guard let code = serverResponse.code else {print("Error: server code"); return}
                            let appError = AppError(code: code, status: status)
                            completion(ServerResponse.error(error: appError))
                            debugPrint("default case: Error loading homeItem")
                        }
                    } catch(let error) {
                        debugPrint(error)
                        return
                    }
                case .failure(let error):
                    print(error)
                    completion(ServerResponse.error(error: AppError.noInternetConnection))
                    print("failure")
                }
        }
    }
    
    
}
