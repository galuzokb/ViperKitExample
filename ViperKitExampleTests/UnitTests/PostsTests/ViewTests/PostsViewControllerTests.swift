//
//  PostsViewControllerTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample
import ViperKit

class PostsViewControllerTests: PostsTests {
    func testViewDidLoad() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.viewIsReady()
        // then
        XCTAssert(presenter.viewIsReadyCalled)
    }
    
    func testViewWillAppear() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.viewAppearing()
        // then
        XCTAssert(presenter.viewAppearingCalled)
    }
    
    func testEdtiSomeText() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.editSomeText(nil)
        // then
        XCTAssert(presenter.editSomeTextCalled)
    }
    
    func testLogout() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.logout()
        // then
        XCTAssert(presenter.logoutCalled)
    }
    
    func testRefreshPosts() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.refreshPosts()
        // then
        XCTAssert(presenter.refreshPostsCalled)
    }
    
    func testPostSelected() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.postSelected(post: Post(id: 0, userID: nil, title: nil, body: nil))
        // then
        XCTAssert(presenter.postSelectedCalled)
    }
    
    func testDeletePost() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.deletePost(Post(id: 0, userID: nil, title: nil, body: nil))
        // then
        XCTAssert(presenter.deletePostCalled)
    }
    
    func testSetupDisplayManager() {
        // given
        viewController.displayManager = nil
        // when
        viewController.displayManager = displayManager
        displayManager.delegate = viewController
        // then
        XCTAssert(viewController.didSetDisplayManager, "Display manager haven't been set")
        XCTAssert(displayManager.didSetDelegate, "View controller hasn't been set as delegate for display manager")
    }
    
    func testSetItems() {
        // given
        let posts: [Post] = []
        viewController.displayManager = displayManager
        displayManager.delegate = viewController
        // when
        viewController.displayManager.items = posts
        // then
        XCTAssert(viewController.displayManager.itemsDidSet)
    }
    
    func testSetupCreatePostBtnEnabled() {
        // given
        let btn = viewController.createPostBtn
        let state = true
        // when
        btn?.isEnabled = state
        // then
        XCTAssertNotNil(btn)
        XCTAssert(btn!.isEnabled, "Should be enabled")
    }
    
    func testSetupCreatePostBtnDisabled() {
        // given
        let btn = viewController.createPostBtn
        let state = false
        // when
        btn?.isEnabled = state
        // then
        XCTAssertNotNil(btn)
        XCTAssert(!btn!.isEnabled, "Should be disabled")
    }
}
