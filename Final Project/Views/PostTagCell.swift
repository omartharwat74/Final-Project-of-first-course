//
//  PostTagsCell.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/14/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class PostTagCell: UICollectionViewCell {
    
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var backView: UIView! {
        didSet{
            backView.layer.cornerRadius = 8
        }
    }
    
}
