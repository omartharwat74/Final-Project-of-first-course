//
//  ProfileVC.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/9/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit
class ProfileVC: UIViewController {
    var user : User!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet{
             profileImageView.makeCircularImage()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        UserAPI.getUserData(id: user.id) { (userResponse) in
            self.user = userResponse
            self.setUpUI()
        }
       
        
        
    }
    func setUpUI(){
               nameLabel.text = user.firstName + " " + user.lastName
        if let image = user.picture {
             profileImageView.setImageFromStringUrl(stringUrl: image)
        }
                          
                          
                           genderLabel.text = user.gender
                           phoneLabel.text = user.phone
                           emailLabel.text = user.email
        if let location = user.location {
            countryLabel.text = location.country! + " - " + location.city!
        }
                        
        
        
        
           }

  

}
