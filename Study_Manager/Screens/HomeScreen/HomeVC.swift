//
//  HomeVC.swift
//  Study_Manager
//
//  Created by Dat Truong on 24/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit

protocol HomeVCProtocol: class {
    
    func showLoading()
    
    func hideLoading()
    
    func onShowError(error: AppError)
    
    func onGetAvailableCoursesSuccess(homeCourses: [CourseDetail])
    
    func onShowFilteredCourses(homeCourses: [CourseDetail])
    
    func onShowFilteringNoResult()
    
    func onGetCourseSuccess(course: CourseDetail)
    
}

class HomeVC: UIViewController, HomeVCProtocol {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var notFoundLbl: UILabel!
    @IBOutlet weak var chooseCategoryBtn: UIButton!

    //MARK: - Properties
    var courses = [CourseDetail]()
    var filteredCourses = [CourseDetail]()
    var searchActive : Bool = false
    var presenter: HomePresenterProtocol?
    var chosenCategory: Category?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(HomeVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.white
        refreshControl.backgroundColor = UIColor.appLightColor
        
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(self.refreshControl)
        
        searchBar.delegate = self
        
        presenter = HomePresenter(view: self)
        
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCourses()
    }
    
    //MARK: - Functions
    private func setupSearchBar() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as! UITextField
        textFieldInsideSearchBar.textColor = UIColor.white
    }
    
    private func goToCourseDetailScreen(courseId: String){
        guard let courseDetailVC = storyboard?.instantiateViewController(withIdentifier: AppStoryBoard.courseDetailVC.identifier) as? CourseDetailVC else {return}
        courseDetailVC.courseId = courseId
        present(courseDetailVC, animated: true, completion: nil)
    }
    
    private func goToCategoryScreen() {
        guard let categoryVC = storyboard?.instantiateViewController(withIdentifier: AppStoryBoard.categoryVC.identifier) as? CategoryVC else {return}
        present(categoryVC, animated: true, completion: nil)
        categoryVC.delegate = self
    }
    
    func loadCourses() {
        if let category = chosenCategory {
            switch category {
            case .all:
                presenter?.performGetAvailableCourses()
            default:
                presenter?.performGetCoursesByCategory(category: category)
                switch category {
                case .art:
                    chooseCategoryBtn.setTitle("Art", for: .normal)
                case .business:
                    chooseCategoryBtn.setTitle("Business", for: .normal)
                case .health:
                    chooseCategoryBtn.setTitle("Health", for: .normal)
                case .free:
                    chooseCategoryBtn.setTitle("Free", for: .normal)
                case .history:
                    chooseCategoryBtn.setTitle("History", for: .normal)
                case .languages:
                    chooseCategoryBtn.setTitle("Languages", for: .normal)
                case .law:
                    chooseCategoryBtn.setTitle("Law", for: .normal)
                case.science:
                    chooseCategoryBtn.setTitle("Science", for: .normal)
                case.nature:
                    chooseCategoryBtn.setTitle("Nature", for: .normal)
                case.literature:
                    chooseCategoryBtn.setTitle("Literature", for: .normal)
                default:
                    print("Error with getting the right category. You should not be here!")
                }
            }
        } else {
            presenter?.performGetAvailableCourses()
        }
    }
    
    //MARK: Actions
    @IBAction func categoryBtnWasPressed(_ sender: Any) {
        goToCategoryScreen()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Protocols
    func showLoading() {
        if !refreshControl.isRefreshing {
            showLoadingIndicator()
        }
    }
    
    func hideLoading() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        } else {
            hideLoadingIndicator()
        }
    }
    
    func onShowError(error: AppError) {
        showError(message: error.description)
    }
    
    func onGetAvailableCoursesSuccess(homeCourses: [CourseDetail]) {
        if homeCourses.count > 0 {
            tableView.isHidden = false
            courses = homeCourses
            notFoundLbl.isHidden = true
            tableView.reloadData()
        } else {
            tableView.isHidden = true
            notFoundLbl.isHidden = false
        }
    }
    
    func onShowFilteredCourses(homeCourses: [CourseDetail]) {
        tableView.isHidden = false
        notFoundLbl.isHidden = true
        filteredCourses = homeCourses
        tableView.reloadData()
    }
    
    func onShowFilteringNoResult() {
        tableView.isHidden = true
        notFoundLbl.isHidden = false
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadCourses()
    }
    
    func onGetCourseSuccess(course: CourseDetail) {
        goToCourseDetailScreen(courseId: course._id)
    }
    
}

// MARK: - Searchbar Delegate
extension HomeVC: UISearchBarDelegate {
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchActive && !searchBarIsEmpty()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.filterContentForSearchText(searchText, courses: courses)
        
    }
}

extension HomeVC: CategoryDelegate {
    func setCategory(category: Category) {
        chosenCategory = category
    }
    
    func setupUI() {
        searchBar.placeholder = "Search Courses"
        notFoundLbl.text = "No such course found"
    }
}

// MARK: - TableView Delegate
extension HomeVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCourses.count
        } else {
            return courses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppTableCell.tableCell.identifier, for: indexPath) as? HomeCourseCell else {
            return UITableViewCell()
        }
        
        let homeCourse: CourseDetail
        
        if isFiltering() {
            homeCourse = filteredCourses[indexPath.row]
        } else {
            homeCourse = courses[indexPath.row]
        }
        
        let courseId = homeCourse._id
        cell.config(courseHome: homeCourse)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseDetail = courses[indexPath.row]
        goToCourseDetailScreen(courseId: courseDetail._id)
    }
    
}
