//
//  API.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/10/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API  {
     static let baseURL = "https://dummyapi.io/data/v1"
      static let appId = "625cf3fd520b52aeaf0e7bf3"
      static let headers : HTTPHeaders = [
           "app-id" : appId
       ]
}
