//
//  MyProfileVC.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/15/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MyProfileVC: UIViewController {
    
    // MARK : OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
@IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

       
    }
    
    func setupUI() {
        userImageView.makeCircularImage()
        if let user = UserManger.loggedInUser {
            if let image = user.picture {
                userImageView.setImageFromStringUrl(stringUrl: image)
            }
            nameLabel.text = user.firstName + " " + user.lastName
            firstNameTextField.text = user.firstName
            phoneTextField.text = user.phone
            imageUrlTextField.text = user.picture
        }
    }
    
    // MARK : ACTIONS
    @IBAction func submitButtonClicked(_ sender: Any) {
        guard let loggedInUser = UserManger.loggedInUser else {return}
        loaderView.startAnimating()
        UserAPI.updateUserInfo(firstName: firstNameTextField.text!, phone: phoneTextField.text!, imageUrl: imageUrlTextField.text!, userId: loggedInUser.id) { user , message in
            self.loaderView.stopAnimating()
            if let responseUser = user {
                if let image = user?.picture {
                    self.userImageView.setImageFromStringUrl(stringUrl: image)
                }
                self.nameLabel.text = responseUser.firstName + " " + responseUser.lastName
            }
        }
    }
    

}
