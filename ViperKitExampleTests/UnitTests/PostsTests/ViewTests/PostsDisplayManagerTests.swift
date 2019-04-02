//
//  PostsDisplayManagerTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostsDisplayManagerTests: PostsTests {
    func testSetChanegdExistingPost() {
        // given
        let changedPost = Post(id: 2, userID: 1, title: "changed", body: "changed")
        var posts: [Post] = [
            Post(id: 0, userID: 1, title: "zero", body: "zero"),
            Post(id: 1, userID: 1, title: "one", body: "one"),
            Post(id: 2, userID: 1, title: "two", body: "two")
        ]
        var postChanged = false
        // when
        var i = 0
        for post in posts {
            if post.id == changedPost.id {
                posts[i] = changedPost
                return
            }
            i += 1
        }
        // then
        for post in posts {
            if post == changedPost {
                postChanged = true
                return
            }
        }
        XCTAssert(postChanged)
    }
    
    func testDeletePostDM() {
        // given
        let post = Post(id: 0, userID: 2, title: "title", body: "body")
        viewController.displayManager = displayManager
        displayManager.delegate = viewController
        // when
        viewController.displayManager.delegate?.deletePost(post)
        // then
        XCTAssert(viewController.deletePostCalled)
    }
}
