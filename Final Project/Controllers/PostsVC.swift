//
//  ViewController.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/3/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class PostsVC: UIViewController {

    @IBOutlet weak var newPostButtonContainerView: ShadowView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagContainerView: UIView!
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var postTableView: UITableView!
    var posts : [Post] = []
    var tag : String?
    var page = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAded), name: NSNotification.Name(rawValue : "NewPostAded"), object: nil)
        tagContainerView.layer.cornerRadius = 10
        // check if user is logged in or it's only to guest
        if let user = UserManger.loggedInUser{
            hiLabel.text =  "Hi , \(user.firstName)"
        }else {
            hiLabel.isHidden = true
            newPostButtonContainerView.isHidden = true
        }
        // check if there is a tag
        if let myTag = tag {
            tagNameLabel.text = myTag
        } else {
            tagContainerView.isHidden = true
            tagNameLabel.isHidden = true
            closeButton.isHidden = true
        }
        
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        // subscribing to the notification
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name("userStackViewTapped"), object: nil)
        
        getPosts()
        
    }
    func getPosts(){
        loaderView.startAnimating()
        PostAPI.getAllPosts(page: page, tag: tag ) { (postsResponse,total) in
            self.total = total
            self.posts.append(contentsOf: postsResponse)
            self.postTableView.reloadData()
            self.loaderView.stopAnimating()
        }
    }
    @objc func newPostAded() {
        self.posts = []
        self.page = 0
        getPosts()
        
    }
    
     // MARK : ACTIONS
    
    @IBAction func closeButtonclicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue" {
            UserManger.loggedInUser = nil
        }
    }
    
    
    @objc func userProfileTapped(notification : Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if  let indexpath = postTableView.indexPath(for: cell) {
                let post = posts[indexpath.row]

                let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
                vc.user = post.owner
                present(vc, animated: true, completion: nil)
            }
            
        }
        
    }


}
extension PostsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        cell.postTextLabel.text = post.text
        //the logic of filling the post's image from the url
        let imageStringUrl = post.image
        cell.postImageView.setImageFromStringUrl(stringUrl: imageStringUrl)
        // the logic of filling the user's image from the url
        cell.userImageView.makeCircularImage()
        let userImageStringUrl = post.owner.picture
        if let image = userImageStringUrl {
             cell.userImageView.setImageFromStringUrl(stringUrl: image)
        }
       
        
        // filling the user data
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        cell.likesNumberLabel.text = String( post.likes)
        
        cell.tags = post.tags ?? []
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 632
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = posts[indexPath.row ]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsVC
        vc.post = selectedPost
        present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 && posts.count < total {
            page += 1
            getPosts()
        }
    }
    
}
