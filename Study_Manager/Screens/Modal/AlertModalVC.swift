//
//  AlertModalVC.swift
//  Study_Manager
//
//  Created by Dat Truong on 22/04/2019.
//  Copyright © 2019 Dat Truong. All rights reserved.
//

import UIKit

enum AlertType {
    case success
    case error
}

class AlertModalVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var modalBackGround: UIView!
    
    var modalTitle: String?
    var modalMessage: String?
    var modalButtonText: String?
    var modalAlertType:AlertType?
    var completion: (()->Void)?
    
    func config(title: String, message: String, buttonText: String, alertType: AlertType, completion: (()->Void)? = nil) {
        modalTitle = title
        modalMessage = message
        modalButtonText = buttonText
        modalAlertType = alertType
        self.completion = completion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(modalTitle)
        guard let modalTitle = self.modalTitle, let modalMessage = self.modalMessage,
            let modalButtonText = self.modalButtonText else {return}
        print(modalTitle)
        titleLbl.text = modalTitle
        messageLbl.text = modalMessage
        button.setTitle(modalButtonText, for: .normal)
        
        if let alertType = self.modalAlertType {
            switch alertType {
            case .error:
                modalBackGround.backgroundColor = UIColor.errorColor
            case .success:
                modalBackGround.backgroundColor = UIColor.appDefaultColor
            }
        }
    }
    
    @IBAction func btnWasPressed(_ sender: Any) {
        dismiss(animated: false, completion: completion)
    }

}
