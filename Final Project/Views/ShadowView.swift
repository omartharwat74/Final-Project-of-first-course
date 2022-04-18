//
//  ShadowView.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/9/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        sutupShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sutupShadow()
    }
    func sutupShadow(){
        self.layer.shadowColor = UIColor.gray.cgColor
                       self.layer.shadowOpacity = 0.3
                       self.layer.shadowOffset = CGSize(width: 0, height: 10)
                       self.layer.shadowRadius = 10
                       self.layer.cornerRadius = 7
        }
    }
    

