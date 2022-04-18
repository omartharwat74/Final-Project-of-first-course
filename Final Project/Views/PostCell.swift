//
//  PostCell.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/3/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    var  tags : [String] = []
    // MARK : OUTLETS
    @IBOutlet weak var userStackView: UIStackView! {
        didSet{
            userStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
        }
    }
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var backView: UIView! {
        didSet{
            backView.layer.shadowColor = UIColor.gray.cgColor
            backView.layer.shadowOpacity = 0.3
            backView.layer.shadowOffset = CGSize(width: 0, height: 10)
            backView.layer.shadowRadius = 10
            backView.layer.cornerRadius = 7
            
        }
    }
    
    @IBOutlet weak var likesNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet weak var tagsCollectionView: UICollectionView! {
        didSet{
            tagsCollectionView.delegate = self
            tagsCollectionView.dataSource = self
        }
    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    // MARK : ACTIONS
    @objc func userStackViewTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("userStackViewTapped"), object: nil, userInfo: ["cell" : self])
    }

}
extension PostCell : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagCell", for: indexPath) as! PostTagCell
        cell.tagNameLabel.text = tags[indexPath.row]
        
        return cell
    }
    
    
}
