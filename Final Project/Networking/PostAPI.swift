//
//  PostAPI.swift
//  Final Project
//
//  Created by Omar Tharwat on 4/10/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class PostAPI : API {
   
    static func getAllPosts (page : Int ,tag: String?,completionHandler : @escaping ([Post], Int) -> () ){
        var url = "\(baseURL)/post"
        if var myTag = tag {
            myTag = myTag.trimmingCharacters(in: .whitespaces)
             url = "\(baseURL)/tag/\(myTag)/post"
        }
        let params = ["page" : "\(page)"]
        
              
        
           AF.request(url,parameters: params,encoder: URLEncodedFormParameterEncoder.default ,headers:headers ).responseJSON { response in
                  let jsonData = JSON(response.value)
                  let data = jsonData["data"]
            let total = jsonData["total"].intValue
            
                  let decoder = JSONDecoder()
                  do {
                       let posts = try decoder.decode([Post].self, from: data.rawData())
                      completionHandler(posts,total)
                  }catch let error {
                      print(error)
                  }
                  print(data)
              }
    }
    static func addNewPost( text : String , userId : String , completionHandler :@escaping () ->() ){
           // SEND THE REQUEST
           let url = "\(baseURL)/post/create"
           let params = [
               "text" : text,
               "owner"  : userId
                        ]
           AF.request(url,method: .post,parameters: params,encoder: JSONParameterEncoder.default ,headers:headers ).validate().responseJSON { response in
               switch response.result {
               case .success:
                completionHandler()
               case .failure(let error) :
                   print(error)
                  
               }
                    
                }

       }
    static func getPostComment(id : String,completionHandler : @escaping([Comment]) ->()) {
              let url = "\(baseURL)/post/\(id)/comment"
                      AF.request(url, headers:headers ).responseJSON { response in
                          let jsonData = JSON(response.value)
                          let data = jsonData["data"]
                          let decoder = JSONDecoder()
                          do {
                              let comments = try decoder.decode([Comment].self, from: data.rawData())
                              completionHandler(comments)
                          }catch let error {
                              print(error)
                          }
                          print(data)
                      }
    }
    //  MARK : COMMENT API
    static func addNewCommentToPost( postId : String , userId : String , message : String , completionHandler :@escaping () ->() ){
        // SEND THE REQUEST
        let url = "\(baseURL)/comment/create"
        let params = [
            "post" : postId,
            "owner"  : userId,
            "message"     : message
                     ]
        AF.request(url,method: .post,parameters: params,encoder: JSONParameterEncoder.default ,headers:headers ).validate().responseJSON { response in
            switch response.result {
            case .success:
             completionHandler()
            case .failure(let error) :
                print(error)
               
            }
                 
             }

    }
    static func getAllTags (completionHandler : @escaping ([ String ]) -> () ){
        
              
              let url = "\(baseURL)/tag"
              AF.request(url, headers:headers ).responseJSON { response in
                  let jsonData = JSON(response.value)
                  let data = jsonData["data"]
                  let decoder = JSONDecoder()
                  do {
                       let tags = try decoder.decode([String].self, from: data.rawData())
                      completionHandler(tags)
                  }catch let error {
                      print(error)
                  }
                  print(data)
              }
    }
}
