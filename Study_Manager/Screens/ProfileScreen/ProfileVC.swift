//
//  ProfileVC.swift
//  Study_Manager
//
//  Created by Dat Truong on 23/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit

protocol ProfileViewProtocol: class {
    
    func onLoadDataSuccess(userData: User)
    
    func onLoadDataError(error: AppError)
    
    func showLoading()
    
    func hideLoading()
    
    func onLogoutSuccess()
    
    func setUpLoadMyProfile()
}

class ProfileVC: UIViewController, ProfileViewProtocol {

    //MARK: - Outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var showCourseBtn: UIButton!
    
    //MARK: - Properties
    var presenter: ProfilePresenterProtocol?
    var userId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = ProfilePresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadUserInfo()
    }
    
    //MARK: - Actions
    @IBAction func logOutBtnWasPressed(_ sender: Any) {
        
        let alertViewController = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.presenter?.logout()
        }
        let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancleAction)
        present(alertViewController, animated: true)
    }
    
    @IBAction func editProfileButtonWasPressed(_ sender: Any) {
        guard let editProfileVC = storyboard?.instantiateViewController(withIdentifier: AppStoryBoard.editProfileVC.identifier) as? EditProfileVC else {return}
        present(editProfileVC, animated: true, completion: nil)
    }
    
    @IBAction func showCourseButtonWasPressed(_ sender: Any) {
        guard let enrolledCourseVC = storyboard?.instantiateViewController(withIdentifier: AppStoryBoard.enrolledCourseVC.identifier) as? EnrolledCoursesVC else {return}
        enrolledCourseVC.userId = userId
        present(enrolledCourseVC, animated: true, completion: nil)
    }
    
    //MARK: Helper
    func setUpLoadMyProfile() {
        editProfileBtn.isHidden = false
        logOutBtn.isHidden = false
    }
    
    func setupUI() {
        editProfileBtn.setTitle("Edit Profile", for: .normal)
        showCourseBtn.setTitle("Courses", for: .normal)
        logOutBtn.setTitle("Logout", for: .normal)
    }
    
    private func goToCourseEnrolledScreen(userId: String){
        guard let enrolledCourseVC = storyboard?.instantiateViewController(withIdentifier: AppStoryBoard.enrolledCourseVC.identifier) as? EnrolledCoursesVC else {return}
        enrolledCourseVC.userId = userId
        present(enrolledCourseVC, animated: true, completion: nil)
    }
    
    //MARK: - Protocols
    
    func onLoadDataSuccess(userData: User) {
        userNameLabel.text = userData.username
        emailLabel.text = userData.email
        phoneNumberLabel.text = userData.phoneNumber
        ageLabel.text = userData.age
        schoolLabel.text = userData.school
        userId = userData._id
    }
    
    func onLogoutSuccess() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let authVC = storyBoard.instantiateViewController(withIdentifier: AppStoryBoard.authVC.identifier)
        appDelegate.window?.rootViewController = authVC
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func onLoadDataError(error: AppError) {
        showError(message: error.description)
    }
    
    func showLoading() {
        showLoadingIndicator()
    }
    
    func hideLoading() {
        hideLoadingIndicator()
    }
}
