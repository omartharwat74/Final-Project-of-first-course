//
//  UIImage+StringUrlToImage.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/8/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    
    func setImageFromStringUrl(stringUrl : String) {
        if let url = URL(string: stringUrl){
            if let imageData = try? Data(contentsOf: url){
                self.image = UIImage(data: imageData)
            }
        }
    }
    func makeCircularImage () {
        self.layer.cornerRadius = self.frame.width / 2

    }
}
