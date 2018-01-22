//
//  PostService.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import PromiseKit

class PostService: PostServiceType {
    
    let postRepo: PostRepositoryType
    
    init(postRepo: PostRepositoryType) {
        self.postRepo = postRepo
    }
    
    func getPosts(forUser userID: Int?) -> Promise<[Post]> {
        if let userID = userID {
            return firstly {
                self.postRepo.getPosts(forUser: userID)
            }
        } else {
            return firstly {
                self.postRepo.getPosts()
            }
        }
    }
    
    func getPost(_ id: Int) -> Promise<Post> {
        return firstly {
            self.postRepo.getPost(id)
        }
    }
    
    func sendPost(_ id: Int, post: Post) -> Promise<Void> {
        return firstly {
            self.postRepo.sendPost(id, post: post)
        }
    }
    
    func changePostTitle(_ id: Int, title: String) -> Promise<Void> {
        return firstly {
            self.postRepo.changePostTitle(id, title: title)
        }
    }
    
    func changePostBody(_ id: Int, body: String) -> Promise<Void> {
        return firstly {
            self.postRepo.changePostBody(id, body: body)
        }
    }
    
    func changePostTitleAndBody(_ id: Int, title: String, body: String) -> Promise<Void> {
        return firstly {
            self.postRepo.changePostBodyAndTitle(id, title: title, body: body)
        }
    }
    
    func deletePost(_ id: Int) -> Promise<Void> {
        return firstly {
            self.postRepo.deletePost(id)
        }
    }
    
    func getComments(forPostID postID: Int) -> Promise<Void> {
        return firstly {
            self.postRepo.getComments(forPostID: postID)
        }
    }
    
}
