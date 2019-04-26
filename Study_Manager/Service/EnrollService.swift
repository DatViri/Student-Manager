//
//  EnrollService.swift
//  Study_Manager
//
//  Created by Dat Truong on 25/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation
import Alamofire
import Stripe

protocol EnrollServiceProtocol {
    
    func getCoursesEnrollByMe(userId: String, completion: @escaping (ServerResponse<[CourseDetail]>) -> Void)
    
    func getEnrollById(enrollId: String, completion: @escaping (ServerResponse<EnrollDetail>) -> Void)
    
    func createEnroll(token: String, courseId: String, source: String, completion: @escaping (ServerResponse<Enroll>) -> Void)
}

class EnrollService: NSObject, EnrollServiceProtocol, STPEphemeralKeyProvider {
    
    
    let jsonDecoder = JSONDecoder()
    
    func getEnrollById(enrollId: String, completion: @escaping (ServerResponse<EnrollDetail>) -> Void) {
        Alamofire.request(
            URL(string: URLConst.BASE_URL + URLConst.ENROLL_PATH + enrollId)!,
            method: .get)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let serverResponse = try self.jsonDecoder.decode(Response<EnrollDetail>.self, from: response.data!)
                        let status = serverResponse.status
                        switch status {
                        case 200:
                            guard let enroll = serverResponse.data else {debugPrint("Error loading enroll"); return}
                            completion(ServerResponse.success(enroll))
                        default:
                            guard let code = serverResponse.code else {print("Error: server code"); return}
                            let appError = AppError(code: code, status: status)
                            completion(ServerResponse.error(error: appError))
                            debugPrint("default case: Error loading order")
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
    
    func createEnroll(token: String, courseId: String, source: String, completion: @escaping (ServerResponse<Enroll>) -> Void) {
        let headers: HTTPHeaders = ["authorization": token, "source": source]
        let parameters: Parameters = ["courseId": courseId]
        Alamofire.request(
            URL(string: URLConst.BASE_URL + URLConst.ENROLL_PATH_COURSES + courseId)!,
            method: .post,
            parameters: parameters,
            headers: headers)
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success:
                    do {
                        let serverResponse = try self.jsonDecoder.decode(Response<Enroll>.self, from: response.data!)
                        let status = serverResponse.status
                        switch status {
                        case 200:
                            guard let newEnroll = serverResponse.data else {debugPrint("Error creating new enroll"); return}
                            completion(ServerResponse.success(newEnroll))
                        default:
                            guard let code = serverResponse.code else {print("Error: server code"); return}
                            let appError = AppError(code: code, status: status)
                            completion(ServerResponse.error(error: appError))
                            debugPrint("default case: Error creating new enroll")
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
    
    func getCoursesEnrollByMe(userId: String, completion: @escaping (ServerResponse<[CourseDetail]>) -> Void) {
        Alamofire.request(
            URL(string: URLConst.BASE_URL + URLConst.ENROLL_PATH_USERS + userId)!,
            method: .get)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let serverResponse = try self.jsonDecoder.decode(Response<[CourseDetail]>.self, from: response.data!)
                        let status = serverResponse.status
                        switch status {
                        case 200:
                            guard let didEnroll = serverResponse.data else {debugPrint("Error loading enroll courses"); return}
                            completion(ServerResponse.success(didEnroll))
                        default:
                            guard let code = serverResponse.code else {print("Error: server code"); return}
                            let appError = AppError(code: code, status: status)
                            completion(ServerResponse.error(error: appError))
                            debugPrint("Error loading bought Items")
                        }
                    } catch(let error) {
                        debugPrint(error)
                        return
                    }
                case .failure(let error):
                    print(error)
                    completion(ServerResponse.error(error: AppError.noInternetConnection))
                }
        }
    }
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url =  URL(string: URLConst.BASE_URL + URLConst.PAYMENT_KEY_PATH)!
        guard let token = KeyChainUtil.share.getToken() else {return}
        let headers: HTTPHeaders = ["authorization": token]
        Alamofire.request(url, method: .post, parameters: [
            "api_version": apiVersion
            ], headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    print("CREATE CUSTOMER KEY ERROR: \(error.localizedDescription)")
                    completion(nil, error)
                }
        }
    }
    
}
