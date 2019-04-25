//
//  CourseDetailVC.swift
//  Study_Manager
//
//  Created by Dat Truong on 25/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit

protocol CourseDetailVCProtocol: class {
    
    func onGetCourseSuccess(course: CourseDetail)
    
    func onShowError(error: AppError)
    
    func showLoading()
    
    func hideLoading()
}

class CourseDetailVC: UIViewController, CourseDetailVCProtocol {

    // MARK: - Properties
    var courseId: String?
    var presenter: CourseDetailPresenterProtocol?

    // MARK: - Outlets
    @IBOutlet weak var courseNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var coursePriceLbl: UILabel!
    @IBOutlet weak var courseCategoryLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var enrollBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter = CourseDetailPresenter(view: self)
        
        if let courseId = self.courseId {
            presenter?.performGetCourse(courseId: courseId)
        }
    }
    
    // MARK: - Protocols
    func onGetCourseSuccess(course: CourseDetail) {
        courseNameLbl.text = course.courseName
        descriptionLbl.text = course.description
        coursePriceLbl.text = String(course.price)
        courseCategoryLbl.text = course.category
    }
    
    func onShowError(error: AppError) {
        showError(message: error.description)
    }
    
    func showLoading() {
        showLoadingIndicator()
    }
    
    func hideLoading() {
        hideLoadingIndicator()
    }
    
    func setupUI() {
        titleLbl.text = "Course Detail"
        cancelBtn.setTitle("Back", for: .normal)
        enrollBtn.setTitle("Enroll", for: .normal)
    }
    
    //MARK: Actions
    @IBAction func closeBtnWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
