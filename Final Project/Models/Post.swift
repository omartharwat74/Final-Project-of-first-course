//
//  Post.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/3/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation
import UIKit
struct Post : Decodable {
    var id : String
    var image : String
    var likes : Int
    var text : String
    var owner : User
    var tags : [String]?
}
