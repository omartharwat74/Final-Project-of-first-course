//
//  CommentCell.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/8/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var commentMessageLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
