//
//  NewPostVC.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/15/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class NewPostVC: UIViewController {
    
    //  MARK : OUTLETS
    @IBOutlet weak var postTextTextField: UITextField!
    @IBOutlet weak var postImageTextField: UITextField!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var addButton: UIButton!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    
    // MARK : ACTIONS
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addPostButtonClicked(_ sender: Any) {
        if let user = UserManger.loggedInUser {
            addButton.setTitle("", for: .normal)
            loaderView.startAnimating()
            PostAPI.addNewPost(text: postTextTextField.text!, userId: user.id ) {
                self.loaderView.stopAnimating()
                self.addButton.setTitle("ADD", for: .normal)
                NotificationCenter.default.post(name:NSNotification.Name("NewPostAded") , object: nil, userInfo: nil )
                self.dismiss(animated: true, completion: nil)
                   }
        }
       
        
    }
    
 

}
