//
//  TagsVC.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/13/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit
import  NVActivityIndicatorView
class TagsVC: UIViewController {
    
    var tags : [String] = []
    // MARK : OUTLETS
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        loaderView.startAnimating()
        PostAPI.getAllTags { tags in
            self.loaderView.stopAnimating()
            self.tags = tags
            self.tagsCollectionView.reloadData()
            
        }

      
    }
    

    
}
extension TagsVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        let currentTag = tags[indexPath.row]
        cell.tagNameLabel.text = currentTag
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTag = tags[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "PostsVC") as! PostsVC
        vc.tag = selectedTag
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
