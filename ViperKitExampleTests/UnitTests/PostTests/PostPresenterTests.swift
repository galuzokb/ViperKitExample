//
//  PostPresenterTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostPresenterTests: PostBaseTests {
    
    var postsAssembliesFactory: MockPostsAssembliesFactory!
    var postsModuleAssembly: MockPostsModuleAssembly!
    var postsViewController: MockPostsViewController!
    
    override func setUp() {
        super.setUp()
        
        postsAssembliesFactory = MockPostsAssembliesFactory()
        postsModuleAssembly = postsAssembliesFactory.resolve()
        postsViewController = try! postsModuleAssembly.container.resolve()
    }
    
    override func tearDown() {
        postsViewController = nil
        postsModuleAssembly = nil
        postsAssembliesFactory = nil
        
        super.tearDown()
    }
    
    func testSetPost() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let post = Post(id: 1, userID: 1, title: "title", body: "body")
        // when
        presenter.post = post
        // then
        XCTAssertTrue(presenter.postDidSet, "post should be set")
    }
    
    func testSetOutput() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let postsPresenter = postsViewController.output as? MockPostsPresenter
        else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        // when
        presenter.output = postsPresenter
        // then
        XCTAssertTrue(presenter.outputDidSet, "output should be set")
    }
    
    func testViewIsReadyWithPost() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let router = presenter.router as? MockPostRouter
        else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let post: Post? = Post(id: 1, userID: 1, title: "title", body: "body")
        // when
        presenter.view?.setupInitialState()
        if let post = post {
            presenter.view?.setupPost(post)
        } else {
            presenter.view?.showError(message: "There is no post")
            presenter.router.close()
        }
        // then
        XCTAssertTrue(viewController.setupInitialStateCalled, "setupInitialState() should be called")
        XCTAssertTrue(viewController.setupPostCalled, "setupPost(..) should be called")
        XCTAssertNil(viewController.errorMessageShowed, "showError(..) shouldn't be called")
        XCTAssertFalse(router.closeCalled, "close() shouldn't be called")
    }
    
    func testViewIsReadyWithoutPost() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let router = presenter.router as? MockPostRouter
        else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let post: Post? = nil
        // when
        presenter.view?.setupInitialState()
        if let post = post {
            presenter.view?.setupPost(post)
        } else {
            presenter.view?.showError(message: "There is no post")
            presenter.router.close()
        }
        // then
        XCTAssertTrue(viewController.setupInitialStateCalled, "setupInitialState() should be called")
        XCTAssertFalse(viewController.setupPostCalled, "setupPost(..) shouldn't be called")
        XCTAssertNotNil(viewController.errorMessageShowed, "showError(..) should be called")
        XCTAssertTrue(router.closeCalled, "close() should be called")
    }
    
    //presenter.post is not nil, new post title and current post title are not equal
    func testTitleDidChangeWithPostAndNewDifferentTitle() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let title = "title"
        let post = Post(id: 1, userID: 1, title: title, body: nil)
        presenter.post = post
        let newTitle = "new title"
        // when
        if let p = presenter.post {
            if let postTitle = p.title, postTitle == newTitle {
                
            } else {
                presenter.view?.setDoneBtnState(true)
            }
        }
        // then
        XCTAssertTrue(viewController.setDoneBtnStateCalled, "setDoneBtnState(..) should be called")
    }
    
    func testTitleDidChangeWithPostAndNewSameTitle() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let title = "title"
        let post = Post(id: 1, userID: 1, title: title, body: nil)
        presenter.post = post
        let newTitle = "title"
        // when
        if let p = presenter.post {
            if let postTitle = p.title, postTitle == newTitle {
                
            } else {
                presenter.view?.setDoneBtnState(true)
            }
        }
        // then
        XCTAssertFalse(viewController.setDoneBtnStateCalled, "setDoneBtnState(..) shouldn't be called")
    }
    
    func testTitleDidChangeWithoutPost() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        presenter.post = nil
        let newTitle = "new title"
        // when
        if let p = presenter.post {
            if let postTitle = p.title, postTitle == newTitle {
                
            } else {
                presenter.view?.setDoneBtnState(true)
            }
        }
        // then
        XCTAssertFalse(viewController.setDoneBtnStateCalled, "setDoneBtnState(..) shouldn't be called")
    }
    
    func testBodyDidChangeWithPostAndNewDifferentBody() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let post = Post(id: 1, userID: 1, title: "title", body: "body")
        presenter.post = post
        let newBody = "new body"
        // when
        if let p = presenter.post {
            if let postBody = p.body, postBody == newBody {
                
            } else {
                presenter.view?.setDoneBtnState(true)
            }
        }
        // then
        XCTAssertTrue(viewController.setDoneBtnStateCalled, "setDoneBtn(..) should be called")
    }
    
    func testBodyDidChangeWithPostAndNewSameBody() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let post = Post(id: 1, userID: 1, title: "title", body: "body")
        presenter.post = post
        let newBody = "body"
        // when
        if let p = presenter.post {
            if let postBody = p.body, postBody == newBody {
                
            } else {
                presenter.view?.setDoneBtnState(true)
            }
        }
        // then
        XCTAssertFalse(viewController.setDoneBtnStateCalled, "setDoneBtn(..) shouldn't be called")
    }
    
    func testBodyDidChangeWithoutPost() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        presenter.post = nil
        let newBody = "body"
        // when
        if let p = presenter.post {
            if let postBody = p.body, postBody == newBody {
                
            } else {
                presenter.view?.setDoneBtnState(true)
            }
        }
        // then
        XCTAssertFalse(viewController.setDoneBtnStateCalled, "setDoneBtn(..) shouldn't be called")
    }
    
    func testDoneWithPost() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let router = presenter.router as? MockPostRouter,
            let interactor = presenter.interactor as? MockPostInteractor
        else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let post = Post(id: 1, userID: 1, title: "title", body: "body")
        presenter.post = post
        // when
        if let post = presenter.post {
            presenter.interactor.changePost(post.id, title: post.title, body: post.body)
        } else {
            presenter.router.close()
        }
        // then
        XCTAssertFalse(router.closeCalled, "close() shouldn't be called")
        XCTAssertTrue(interactor.changePostCalled, "changePost(:) should be called")
    }
    
    func testDoneWithoutPost() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let router = presenter.router as? MockPostRouter,
            let interactor = presenter.interactor as? MockPostInteractor
        else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        presenter.post = nil
        // when
        if let post = presenter.post {
            presenter.interactor.changePost(post.id, title: post.title, body: post.body)
        } else {
            presenter.router.close()
        }
        // then
        XCTAssertTrue(router.closeCalled, "close() should be called")
        XCTAssertFalse(interactor.changePostCalled, "changePost(:) shouldn't be called")
    }
    
    func testBack() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let router = presenter.router as? MockPostRouter
        else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        // when
        presenter.router.close()
        // then
        XCTAssertTrue(router.closeCalled, "close() should be called")
    }
    
    func testPostChangedWithPost() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let postsPresenter = postsViewController.output as? MockPostsPresenter
        else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        presenter.output = postsPresenter
        let newTitle: String? = "new title"
        let newBody: String? = "new body"
        let post = Post(id: 1, userID: 1, title: "title", body: "body")
        presenter.post = post
        // when
        presenter.view?.stopIndication()
        presenter.view?.setDoneBtnState(false)
        if let nt = newTitle { presenter.post?.title = nt }
        if let nb = newBody { presenter.post?.body = nb }
        if let p = presenter.post {
            presenter.output?.postChanged(p)
        }
        // then
        XCTAssertTrue(viewController.stopIndicationCalled, "stopIndication should be called")
        XCTAssertTrue(viewController.setDoneBtnStateCalled, "setDoneBtnState should be called")
        XCTAssertEqual(presenter.post?.title, newTitle, "new titile should be set")
        XCTAssertEqual(presenter.post?.body, newBody, "new body should be set")
    }
    
    func testPostChangedWithoutPost() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let postsPresenter = postsViewController.output as? MockPostsPresenter
            else {
                XCTFail("presenter shouldn't be nil")
                return
        }
        presenter.output = postsPresenter
        let newTitle: String? = "new title"
        let newBody: String? = "new body"
        presenter.post = nil
        // when
        presenter.view?.stopIndication()
        presenter.view?.setDoneBtnState(false)
        if let p = presenter.post {
            presenter.output?.postChanged(p)
        }
        // then
        XCTAssertTrue(viewController.stopIndicationCalled, "stopIndication should be called")
        XCTAssertTrue(viewController.setDoneBtnStateCalled, "setDoneBtnState should be called")
        XCTAssertFalse(postsPresenter.postChangedCalled, "postChanged called should be called")
    }
    
    func testEncounteredError() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let errorMessage = "error"
        // when
        presenter.view?.stopIndication()
        presenter.view?.showError(message: errorMessage)
        // then
        XCTAssertTrue(viewController.stopIndicationCalled, "stopIndication should be called")
        XCTAssertEqual(viewController.errorMessageShowed, errorMessage, "error message should be called")
    }
}
