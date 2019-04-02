//
//  PostsPresenterTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/3/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostsPresenterTests: PostsTests {
    func testViewIsReady() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor
        else {
            XCTFail()
            return
        }
        // when
        presenter.view?.setupInitialState()
        presenter.view?.setupDisplayManager()
        presenter.view?.startIndication()
        presenter.interactor.loadData()
        // then
        XCTAssertTrue(viewController.setupInitialStateCalled, "setupInitialState() should be called")
        XCTAssertTrue(viewController.setupDisplayManagerCalled, "setupDisplayManager() should be called")
        XCTAssertTrue(viewController.startIndicationCalled, "startIndication() should be called")
        XCTAssertTrue(interactor.loadDataCalled, "loadData() shoudl be called")
    }
    
    func testEditSomeText() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let router = presenter.router as? MockPostsRouter
        else {
            XCTFail()
            return
        }
        let text = "TEXT"
        // when
        presenter.router.openEditText(withOutput: presenter, text: text)
        // then
        XCTAssertTrue(router.openEditTextCalled, "openEditText(..) should be called")
    }
    
    func testPostSelected() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let router = presenter.router as? MockPostsRouter
            else {
                XCTFail()
                return
        }
        let post = Post(id: 1, userID: 1, title: "title", body: "body")
        // when
        presenter.router.openPost(withOutput: presenter, post: post)
        // then
        XCTAssertTrue(router.openPostCalled, "openPost(..) should be called")
    }
    
    func testRefreshPosts() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor
        else {
            XCTFail()
            return
        }
        presenter.isRefreshing = false
        // when
        presenter.isRefreshing = true
        presenter.interactor.loadData()
        // then
        XCTAssertTrue(presenter.isRefreshing, "isRefreshing should be true")
        XCTAssertTrue(interactor.loadDataCalled, "loadData() should be called")
    }
    
    func testDeletePost() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor
        else {
            XCTFail()
            return
        }
        let post = Post(id: 1, userID: 1, title: "title", body: "body")
        // when
        presenter.interactor.deletePost(post)
        // then
        XCTAssertTrue(interactor.deletePostCalled, "deletePost(post) should be called")
    }
    
    func testLogout() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let interactor = presenter.interactor as? MockPostsInteractor
        else {
            XCTFail()
            return
        }
        // when
        presenter.interactor.logout()
        // then
        XCTAssertTrue(interactor.logoutCalled, "logout() should be called")
    }
    
    func testEncounteredError() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        let error = CustomError(message: "some error")
        // when
        presenter.view?.stopIndication()
        presenter.view?.showError(message: "some error")
        // then
        XCTAssertTrue(viewController.stopIndicationCalled, "stopIndication() should be called")
        XCTAssertNotNil(viewController.errorMessageShowed, "There shoudl be some error message showed")
        XCTAssertEqual(viewController.errorMessageShowed, error.message, "current error should be showed")
    }
    
    func testPostsLoadedOnRefreshing() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        presenter.isRefreshing = true
        presenter.postsDidSet = false
        let posts = [Post(id: 1, userID: 1, title: "title", body: "body")]
        // when
        if presenter.isRefreshing {
            presenter.view?.stopRefreshing()
            presenter.isRefreshing = false
        } else {
            presenter.view?.stopIndication()
        }
        presenter.posts = posts
        presenter.view?.setItems(posts)
        // then
        XCTAssertFalse(presenter.isRefreshing, "isRefreshing should be false")
        XCTAssertTrue(viewController.stopRefreshingCalled, "stopRefreshing() should be called")
        XCTAssertFalse(viewController.stopIndicationCalled, "stopIndication() shouldn't be called")
        XCTAssertTrue(presenter.postsDidSet, "posts should be set")
        XCTAssertTrue(viewController.setItemsCalled, "setItems(..) should be called")
    }
    
    func testPostsLoadedOnInitialLoad() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        presenter.isRefreshing = false
        presenter.postsDidSet = false
        let posts = [Post(id: 1, userID: 1, title: "title", body: "body")]
        // when
        if presenter.isRefreshing {
            presenter.view?.stopRefreshing()
            presenter.isRefreshing = false
        } else {
            presenter.view?.stopIndication()
        }
        presenter.posts = posts
        presenter.view?.setItems(posts)
        // then
        XCTAssertFalse(presenter.isRefreshing, "isRefreshing should be false")
        XCTAssertFalse(viewController.stopRefreshingCalled, "stopRefreshing() shouldn't be called")
        XCTAssertTrue(viewController.stopIndicationCalled, "stopIndication() should be called")
        XCTAssertTrue(presenter.postsDidSet, "posts should be set")
        XCTAssertTrue(viewController.setItemsCalled, "setItems(..) should be called")
    }
    
    func testExistingPostDeleted() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        for i in 1...10 { presenter.posts.append(Post(id: i, userID: 1, title: "title\(i.description)", body: "body\(i.description)")) }
        let copyPosts = presenter.posts
        let postToDetele = Post(id: 3, userID: 1, title: "title3", body: "body3")
        // when
        var i = 0
        for post in copyPosts {
            if post == postToDetele {
                presenter.posts.remove(at: i)
                presenter.view?.setItems(presenter.posts)
                presenter.view?.setupCreatePostBtn(presenter.posts.count < 100)
                break
            }
            i += 1
        }
        // then
        XCTAssertNotEqual(presenter.posts.count, copyPosts.count, "posts count should not be equal")
        XCTAssertTrue(viewController.setItemsCalled, "setItems(..) should be called")
        XCTAssertTrue(viewController.setupCreatePostBtnCalled, "setupCreatePostBtn(..) should be called")
    }
    
    func testNonexistendPostDeleted() {
        // given
        guard let presenter = viewController.output as? MockPostsPresenter else {
            XCTFail()
            return
        }
        for i in 1...10 { presenter.posts.append(Post(id: i, userID: 1, title: "title\(i.description)", body: "body\(i.description)")) }
        let copyPosts = presenter.posts
        let postToDetele = Post(id: 20, userID: 1, title: "title3", body: "body3")
        // when
        var i = 0
        for post in copyPosts {
            if post == postToDetele {
                presenter.posts.remove(at: i)
                presenter.view?.setItems(presenter.posts)
                presenter.view?.setupCreatePostBtn(presenter.posts.count < 100)
                break
            }
            i += 1
        }
        // then
        XCTAssertEqual(presenter.posts.count, copyPosts.count, "posts count should be equal")
        XCTAssertFalse(viewController.setItemsCalled, "setItems(..) shouldn't be called")
        XCTAssertFalse(viewController.setupCreatePostBtnCalled, "setupCreatePostBtn(..) shouldn't be called")
    }
}
