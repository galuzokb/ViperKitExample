//
//  PostRepository.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import PromiseKit

class PostRepository: PostRepositoryType {
    
    let mapping: MappingType
    let network: NetworkType
    
    let baseURL = Constants.URLs.basePostsURL
    
    init(mapping: MappingType, network: NetworkType) {
        self.mapping = mapping
        self.network = network
    }
    
    func getPosts() -> Promise<[Post]> {
        return firstly {
            self.network.request(method: .GET, url: baseURL + "posts")
        }.then { data in
            self.mapping.map(data: data)
        }
    }
    
    func getPost(_ id: Int) -> Promise<Post> {
        return firstly {
            self.network.request(method: .GET, url: baseURL + "potst/\(id)")
        }.then { data in
            self.mapping.map(data: data)
        }
    }
    
    func getPosts(forUser userID: Int) -> Promise<[Post]> {
        return firstly {
            self.network.request(method: .GET, url: baseURL + "posts?userId=\(userID)")
        }.then { data in
            self.mapping.map(data: data)
        }
    }
    
    func sendPost(_ id: Int, post: Post) -> Promise<Void> {
        let json = post.toJSON()
        return firstly {
            self.network.request(method: .PUT, url: baseURL + "posts/\(id)", json: json)
        }.asVoid()
    }
    
    func changePostTitle(_ id: Int, title: String) -> Promise<Void> {
        return firstly {
            self.network.request(method: .PATCH, url: baseURL + "posts/\(id)", json: ["title": title])
        }.asVoid()
    }
    
    func changePostBody(_ id: Int, body: String) -> Promise<Void> {
        return firstly {
            self.network.request(method: .PATCH, url: baseURL + "posts/\(id)", json: ["body": body])
        }.asVoid()
    }
    
    func changePostBodyAndTitle(_ id: Int, title: String, body: String) -> Promise<Void> {
        return firstly {
            self.network.request(method: .PATCH, url: baseURL + "posts/\(id)", json: ["title": title, "body": body])
        }.asVoid()
    }
    
    func deletePost(_ id: Int) -> Promise<Void> {
        return firstly {
            self.network.request(method: .DELETE, url: baseURL + "posts/\(id)")
        }.asVoid()
    }
    
    func getComments(forPostID postID: Int) -> Promise<Void> {
        return firstly {
            self.network.request(method: .GET, url: baseURL + "comments?postId=\(postID)")
        }.asVoid()
    }
    
}
