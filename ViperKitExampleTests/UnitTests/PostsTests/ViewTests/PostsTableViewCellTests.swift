//
//  PostsTableViewCellTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostsTableViewCellTests: PostsTests {
    
    func testSetItemsTVC() {
        // given
        let post = Post(id: 0, userID: 0, title: "title", body: "body")
//        viewController.displayManager.items = [post]
//        guard let cell = viewController.tableView.dequeueReusableCell(withIdentifier: "postsCell", for: IndexPath(item: 0, section: 0)) as? MockPostsTableViewCell else {
//            XCTFail("cant get cell")
//            return
//        }
        postsCell.itemDidSet = false
        // when
        postsCell.setPost(post)
        // then
        XCTAssert(postsCell.itemDidSet, "Posts cell's item should be set")
    }
}
