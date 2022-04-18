//
//  RegisterVC.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/11/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    // MARK : OUTLETS
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK : LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK : ACTIONS
    @IBAction func registerButtonClicked(_ sender: Any){
        UserAPI.registerNewUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!) { (user, errorMessage) in
            if errorMessage != nil {
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Success", message: "User Created", preferredStyle: .alert)
                               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                               alert.addAction(okAction)
                               self.present(alert, animated: true, completion: nil)
            }
        }
        
        }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
