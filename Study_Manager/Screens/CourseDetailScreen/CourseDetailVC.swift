//
//  CourseDetailVC.swift
//  Study_Manager
//
//  Created by Dat Truong on 25/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit
import Stripe

protocol CourseDetailVCProtocol: class {
    func onGetMeSuccess(user: User)
    
    func onGetMeError(error: AppError)
    
    func onGetCourseSuccess(course: CourseDetail)
    
    func onEnrollCourseSuccess(enroll: Enroll)
    
    func onShowError(error: AppError)
    
    func showLoading()
    
    func hideLoading()
}

class CourseDetailVC: UIViewController, CourseDetailVCProtocol {

    // MARK: - Properties
    var courseId: String?
    var presenter: CourseDetailPresenterProtocol?
    
    
    private let customerContext: STPCustomerContext
    private let paymentContext: STPPaymentContext
    private let enrollService: EnrollService

    // MARK: - Outlets
    @IBOutlet weak var courseNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var coursePriceLbl: UILabel!
    @IBOutlet weak var courseCategoryLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var enrollBtn: UIButton!
    
    @IBOutlet weak var instructLbl: UILabel!
    @IBOutlet weak var addCardBtn: UIButton?
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        
        enrollService = EnrollService()
        customerContext = STPCustomerContext(keyProvider: enrollService)
        paymentContext = STPPaymentContext(customerContext: customerContext)
        
        super.init(coder: aDecoder)
        
        paymentContext.delegate = self
        paymentContext.hostViewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter = CourseDetailPresenter(view: self)
        
        if let courseId = self.courseId {
            presenter?.performGetCourse(courseId: courseId)
        }
        
        reloadAddCardButtonContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getMe()
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
        instructLbl.text = "Please select your payment method"
    }
    
    func onGetMeSuccess(user: User) {
    }
    
    func onGetMeError(error: AppError) {
        showError(message: error.description)
    }
    
    //MARK: - Actions
    @IBAction func closeBtnWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCardBtnWasPressed(_ sender: Any) {
        presentPaymentMethodsViewController()
    }
    
    @IBAction func enrollBtnWasPressed(_ sender: Any) {
        let alertViewController = UIAlertController(title: "Enroll", message: "Do you want to enroll this course?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                    print("enroll btn pressed")
                    self.paymentContext.requestPayment()
        }
        let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancleAction)
        self.present(alertViewController, animated: true)
    }

    // MARK: - Helpers
    private func presentPaymentMethodsViewController() {
        STPPaymentConfiguration.shared().publishableKey = KEY.STRIPE
        paymentContext.presentPaymentMethodsViewController()
    }
    
    private func reloadAddCardButtonContent() {
        if let selectedPaymentMethod = paymentContext.selectedPaymentMethod  {
            addCardBtn?.setTitle(selectedPaymentMethod.label, for: .normal)
        } else {
            addCardBtn?.setTitle("Add Card", for: .normal)
        }
    }
    
    func onEnrollCourseSuccess(enroll: Enroll) {
        self.showSuccess(title: "Success", message: "You now have enrolled the course", closeBtnText: "OK")
    }
    
    func goToMainVC() {
        UIApplication.shared.statusBarStyle = .lightContent
        guard let mainVC = storyboard?.instantiateViewController(withIdentifier: AppStoryBoard.mainVC.identifier) else {return}
        present(mainVC, animated: true, completion: nil)
    }
}

extension CourseDetailVC: STPPaymentContextDelegate {
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        paymentContext.retryLoading()
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        reloadAddCardButtonContent()
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        
        let source = paymentResult.source.stripeID
        guard let courseId = courseId else {
            return
        }
        presenter?.performEnrollCourse(courseId: courseId, source: source, completion: { [weak self](user, error) in
            guard error == nil else {
                completion(error)
                return
            }
            
            completion(nil)
        })
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        switch status {
        case .success:
            print("successfully")
        case .error:
            print("abc")
            if let error = error as? AppError {
                showError(message: error.description)
            } else {
                showError(message: AppError.cannotRequestPoint.description)
            }
        case .userCancellation:
            return
        }
    }
}
