
//
//  ProfileService.swift
//  Study_Manager
//
//  Created by Dat Truong on 23/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import Foundation
import Alamofire

protocol ProfileServiceProtocol {
    func loadProfileData(token: String, completion: @escaping (ServerResponse<User>) -> Void)
    func updateProfileData(token: String, username: String, email: String, phoneNumber: String, age: String, school: String, completion: @escaping (ServerResponse<User>) -> Void)
    
}

class ProfileService: ProfileServiceProtocol {
    
    let jsonDecoder = JSONDecoder()
    
    func loadProfileData(token: String, completion: @escaping (ServerResponse<User>) -> Void) {
        let headers: HTTPHeaders = [
            "authorization": token
        ]
        Alamofire.request(
            URL(string: URLConst.BASE_URL + URLConst.USER_ME_PATH)!,method: .get, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let serverResponse = try self.jsonDecoder.decode(Response<User>.self, from: response.data!)
                        let status = serverResponse.status
                        switch status {
                        case 200:
                            guard let userData = serverResponse.data else {debugPrint("Error loading profile"); return}
                            completion(ServerResponse.success(userData))
                        default:
                            guard let code = serverResponse.code else {print("Error: server code"); return}
                            let appError = AppError(code: code, status: status)
                            completion(ServerResponse.error(error: appError))
                            debugPrint("Error loading profile"); return
                        }
                        
                    } catch(let error) {
                        print("Error decode")
                        // Error with parse JSON.
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
    
    func updateProfileData(token: String, username: String, email: String, phoneNumber: String, age: String,school: String, completion: @escaping (ServerResponse<User>) -> Void) {
        let headers: HTTPHeaders = [
            "authorization": token
        ]
        let params: Parameters = [
            "username": username,
            "email": email,
            "phoneNumber": phoneNumber,
            "age": age,
            "school": school
        ]
        Alamofire.request(
            URL(string: URLConst.BASE_URL + URLConst.USER_ME_PATH)!,
            method: .put,
            parameters: params,
            headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let serverResponse = try self.jsonDecoder.decode(Response<User>.self, from: response.data!)
                        let status = serverResponse.status
                        switch status {
                        case 200:
                            guard let userData = serverResponse.data else {debugPrint("Error loading profile"); return}
                            completion(ServerResponse.success(userData))
                        default:
                            guard let code = serverResponse.code else {print("Error: server code"); return}
                            let appError = AppError(code: code, status: status)
                            completion(ServerResponse.error(error: appError))
                            debugPrint("Error loading profile"); return
                        }
                        
                    } catch(let error) {
                        print("Error decode")
                        // Error with parse JSON.
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

