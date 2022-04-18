//
//  User.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/4/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation
import UIKit
struct User : Decodable {
    var id : String
    var firstName : String
    var lastName : String
    var picture : String?
    var phone : String?
    var email : String?
    var gender : String?
    var location : location?
}
