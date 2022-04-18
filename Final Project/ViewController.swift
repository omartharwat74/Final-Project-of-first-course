//
//  ViewController.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/3/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class PostsVC: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    var posts : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.delegate = self
        postTableView.dataSource = self
        let appId = "6249b2f844cd7db54fc408e3"
        let headers : HTTPHeaders = [
            "app-id" : appId
        ]
        let url = "https://dummyapi.io/data/v1/post"
        AF.request(url, headers:headers ).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                self.posts = try decoder.decode([Post].self, from: data.rawData())
                self.postTableView.reloadData()
            }catch let error {
                print(error)
            }
            print(data)
        }
        // Do any additional setup after loading the view.
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
        let imageStringUrl = post.image
        if let url = URL(string: imageStringUrl) {
            if let imageData = try? Data(contentsOf: url) {
                cell.postImageView.image = UIImage(data: imageData)
            }
        }
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 348
    }
    
    
}
