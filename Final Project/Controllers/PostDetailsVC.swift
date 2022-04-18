//
//  PostDetailsVC.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/8/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostDetailsVC: UIViewController {
    var post : Post!
    var comments : [Comment] = []
    // Mark : OUTLETS
   
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
@IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var newCommentSV: UIStackView!
    
    
    
    
    
    // Mark : LIFE CYCLE METHODS
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserManger.loggedInUser == nil {
            newCommentSV.isHidden = true
        }
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        exitButton.layer.cornerRadius = exitButton.frame.width / 2
        userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        postTextLabel.text = post.text
        numberOfLikesLabel.text = String(post.likes)
        if let image = post.owner.picture {
             userImageView.setImageFromStringUrl(stringUrl: image)
        }
       
        userImageView.makeCircularImage()
        let postImageStringUrl = post.image
        postImageView.setImageFromStringUrl(stringUrl: postImageStringUrl)
        
        // API REQUEST
       
       getPostComment()
        
        
       
    }
    func getPostComment(){
         loaderView.startAnimating()
        PostAPI.getPostComment(id: post.id) { (commentsResponse) in
                   self.comments = commentsResponse
                   self.commentsTableView.reloadData()
                   self.loaderView.stopAnimating()
               }
    }
    // Mark :   ACTIONS

    @IBAction func closeButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func sendButtonClicked(_ sender: Any) {
         let message = commentTextField.text!
        if let user = UserManger.loggedInUser {
            PostAPI.addNewCommentToPost(postId: post.id, userId: user.id, message: message) {
                self.getPostComment()
                self.commentTextField.text = ""
            }
        }
        
    }
   
    
}
extension PostDetailsVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as!CommentCell
        let currentComment = comments[indexPath.row]
        cell.commentMessageLabel.text = currentComment.message
        cell.userNameLabel.text = currentComment.owner.firstName + " " + currentComment.owner.lastName
        
        if let userImage = currentComment.owner.picture {
            cell.userImageView.setImageFromStringUrl(stringUrl: userImage)
        }
        cell.userImageView.makeCircularImage()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    
}
