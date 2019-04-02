//
//  PostsInteractorTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/3/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample
import PromiseKit

class PostsInteractorTests: PostsTests {
    func testLoadDataWithourError() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("Presenter, Interactor and PostService shouldn't be nil")
            return
        }
        postService.getPostsWithError = true
        // when
        firstly {
            postService.getPosts(forUser: nil)
        }.then { posts in
            interactor.output?.postsLoaded(posts)
        }.catch { error in
            interactor.output?.encounteredError(error: error)
        }.always {
            // then
            XCTAssertFalse(presenter.postsLoadedCalled, "postLoaded(..) shouldn't be called")
            XCTAssertTrue(presenter.encounteredErrorCalled, "encounteredError(..) should be called")
        }
    }
    
    func testLoadDataWithoutError() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("Presenter, Interactor and PostService shouldn't be nil")
            return
        }
        postService.getPostsWithError = false
        // when
        firstly {
            postService.getPosts(forUser: nil)
        }.then { posts in
            interactor.output?.postsLoaded(posts)
        }.catch { error in
            interactor.output?.encounteredError(error: error)
        }.always {
            // then
            XCTAssertTrue(presenter.postsLoadedCalled, "postLoaded(..) should be called")
            XCTAssertFalse(presenter.encounteredErrorCalled, "encounteredError(..) shouldn't be called")
        }
    }
    
    func testDeletePostWithError() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("Presenter, Interactor and PostService shouldn't be nil")
            return
        }
        let postToDelete = Post(id: 1, userID: 1, title: "title", body: "body")
        postService.deletePostWithError = true
        // when
        firstly {
            interactor.postService.deletePost(1)
        }.then { _ in
            interactor.output?.postDeleted(postToDelete)
        }.catch { error in
            interactor.output?.encounteredError(error: error)
        }.always {
            // then
            XCTAssertTrue(presenter.encounteredErrorCalled, "encounteredError(..) should be called")
            XCTAssertFalse(presenter.postDeletedCalled, "postDeleted() shouldn't be called")
        }
    }
    
    func testDeletePostWithoutError() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("Presenter, Interactor and PostService shouldn't be nil")
            return
        }
        let postToDelete = Post(id: 1, userID: 1, title: "title", body: "body")
        postService.deletePostWithError = false
        // when
        firstly {
            interactor.postService.deletePost(1)
        }.then { _ in
            interactor.output?.postDeleted(postToDelete)
        }.catch { error in
            interactor.output?.encounteredError(error: error)
        }.always {
            // then
            XCTAssertFalse(presenter.encounteredErrorCalled, "encounteredError(..) shouldn't be called")
            XCTAssertTrue(presenter.postDeletedCalled, "postDeleted() should be called")
        }
    }
    
    func testLogout() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor,
            let authService = interactor.authService as? MockAuthorizationService
        else {
            XCTFail("Presenter, Interactor, AuthService shouldn't be nil")
            return
        }
        // when
        interactor.authService.logout()
        // then
        XCTAssertTrue(authService.logoutCalled, "logout() should be called")
    }
}
