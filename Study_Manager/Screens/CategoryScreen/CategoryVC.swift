//
//  CategoryVC.swift
//  Study_Manager
//
//  Created by Dat Truong on 24/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit

protocol CategoryDelegate {
    func setCategory(category: Category)
}

class CategoryVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var businessBtn: UIButton!
    @IBOutlet weak var artBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var healthBtn: UIButton!
    @IBOutlet weak var natureBtn: UIButton!
    @IBOutlet weak var languagesBtn: UIButton!
    @IBOutlet weak var lawBtn: UIButton!
    @IBOutlet weak var literatureBtn: UIButton!
    @IBOutlet weak var scienceBtn: UIButton!
    @IBOutlet weak var freeBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    //MARK: - Properties
    var delegate: CategoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - Protocols
    func setCategory(category: Category) {
        delegate?.setCategory(category: category)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func allBtnWasPressed(_ sender: Any) {
        setCategory(category: .all)
    }
    
    @IBAction func businessBtnWasPressed(_ sender: Any) {
        setCategory(category: .business)
    }
    
    @IBAction func artBtnWasPressed(_ sender: Any) {
        setCategory(category: .art)
    }
    
    @IBAction func historyBtnWasPressed(_ sender: Any) {
        setCategory(category: .history)
    }

    @IBAction func healthBtnWasPressed(_ sender: Any) {
        setCategory(category: .health)
    }
    
    @IBAction func natureBtnWasPressed(_ sender: Any) {
        setCategory(category: .nature)
    }
    
    @IBAction func languagesBtnWasPressed(_ sender: Any) {
        setCategory(category: .languages)
    }
    
    @IBAction func lawBtnWasPressed(_ sender: Any) {
        setCategory(category: .law)
    }
    
    @IBAction func literatureBtnWasPressed(_ sender: Any) {
        setCategory(category: .literature)
    }
    
    @IBAction func scienceBtnWasPressed(_ sender: Any) {
        setCategory(category: .science)
    }
    
    @IBAction func freeBtnWasPressed(_ sender: Any) {
        setCategory(category: .free)
    }
    
    func setupUI() {
        titleLbl.text = "Category"
        cancelBtn.setTitle("Cancel", for: .normal)
        allBtn.setTitle("All", for: .normal)
        businessBtn.setTitle("Business", for: .normal)
        artBtn.setTitle("Art", for: .normal)
        historyBtn.setTitle("History", for: .normal)
        healthBtn.setTitle("Health", for: .normal)
        natureBtn.setTitle("Nature", for: .normal)
        languagesBtn.setTitle("Languages", for: .normal)
        lawBtn.setTitle("Law", for: .normal)
        literatureBtn.setTitle("Literature", for: .normal)
        scienceBtn.setTitle("Science", for: .normal)
        freeBtn.setTitle("Free", for: .normal)
    }
}
