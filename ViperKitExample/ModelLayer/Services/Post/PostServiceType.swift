//
//  PostServiceType.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import PromiseKit

protocol PostServiceType {
    func getPosts(forUser userID: Int?) -> Promise<[Post]>
    func getPost(_ id: Int) -> Promise<Post>
    
    func sendPost(_ id: Int, post: Post) -> Promise<Void>
    func changePostTitle(_ id: Int, title: String) -> Promise<Void>
    func changePostBody(_ id: Int, body: String) -> Promise<Void>
    func changePostTitleAndBody(_ id: Int, title: String, body: String) -> Promise<Void>
    func deletePost(_ id: Int) -> Promise<Void>
    
    func getComments(forPostID postID: Int) -> Promise<Void>
}
