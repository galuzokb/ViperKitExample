//
//  PostServiceStub.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

@testable import ViperKitExample
import PromiseKit

class MockPostService: PostServiceType {
    
    var getPostsCalled = false
    var getPostCalled = false
    var sendPostCalled = false
    var changePostTitleCalled = false
    var changePostBodyCalled = false
    var changePostTitleAndBodyCalled = false
    var deletePostCalled = false
    var getCommentsCalled = false
    
    var getPostsWithError = false
    var getPostWithError = false
    var sendPostWithError = false
    var changePostTitleWithError = false
    var changePostBodyWithError = false
    var changePostTitleAndBodyWithError = false
    var deletePostWithError = false
    var getCommentsWithError = false
    
    func getPosts(forUser userID: Int?) -> Promise<[Post]> {
        getPostsCalled = true
        if getPostsWithError {
            return Promise(error: CustomError(message: "Posts Error"))
        } else {
            return Promise(value: [])
        }
    }
    
    func getPost(_ id: Int) -> Promise<Post> {
        getPostCalled = true
        if getPostWithError {
            return Promise(error: CustomError(message: "Posts Error"))
        } else {
            return Promise(value: Post(id: 0, userID: nil, title: nil, body: nil))
        }
    }
    
    func sendPost(_ id: Int, post: Post) -> Promise<Void> {
        sendPostCalled = true
        if sendPostWithError {
            return Promise(error: CustomError(message: "Posts Error"))
        } else {
            return Promise()
        }
    }
    
    func changePostTitle(_ id: Int, title: String) -> Promise<Void> {
        changePostTitleCalled = true
        if changePostTitleWithError {
            return Promise(error: CustomError(message: "Posts Error"))
        } else {
            return Promise()
        }
    }
    
    func changePostBody(_ id: Int, body: String) -> Promise<Void> {
        changePostBodyCalled = true
        if changePostBodyWithError {
            return Promise(error: CustomError(message: "Posts Error"))
        } else {
            return Promise()
        }
    }
    
    func changePostTitleAndBody(_ id: Int, title: String, body: String) -> Promise<Void> {
        changePostTitleAndBodyCalled = true
        if changePostTitleAndBodyWithError {
            return Promise(error: CustomError(message: "Posts Error"))
        } else {
            return Promise()
        }
    }
    
    func deletePost(_ id: Int) -> Promise<Void> {
        deletePostCalled = true
        if deletePostWithError {
            return Promise(error: CustomError(message: "Posts Error"))
        } else {
            return Promise()
        }
    }
    
    func getComments(forPostID postID: Int) -> Promise<Void> {
        getCommentsCalled = true
        if getCommentsWithError {
            return Promise(error: CustomError(message: "Posts Error"))
        } else {
            return Promise()
        }
    }
}
