//
//  Comment.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/8/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation
struct Comment : Decodable {
    var id : String
    var message : String
    var owner : User
}
