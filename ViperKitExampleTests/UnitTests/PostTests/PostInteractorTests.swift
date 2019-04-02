//
//  PostInteractorTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

//PostInteractor.changePost - является кандидатом для рефакторинга

import Foundation
@testable import ViperKitExample
import PromiseKit

class PostInteractorTests: PostBaseTests {
    
    func testChangePostWithoutTitleAndBody() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let interactor = presenter.interactor as? MockPostInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("presenter and interactor shouldn't be nil")
            return
        }
        let title: String? = nil
        let body: String? = nil
        // when
        if let _ = title, let _ = body {
            XCTFail("shouldn't be here")
        } else if title != nil {
            XCTFail("shouldn't be here")
        } else if body != nil {
            XCTFail("shouldn't be here")
        } else {
            // then
            XCTAssertTrue(true)
        }
    }
    
    func testChangePostWithTitleAndWhithoutBodyWithoutErrorResponse() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let interactor = presenter.interactor as? MockPostInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("presenter and interactor shouldn't be nil")
            return
        }
        let title: String? = "title"
        let body: String? = nil
        postService.changePostTitleWithError = false
        // when
        if let _ = title, let _ = body {
            XCTFail("shouldn't be here")
        } else if let title = title {
            firstly {
                interactor.postService.changePostTitle(1, title: title)
            }.then { _ -> Promise<Void> in
                interactor.output?.postChanged(withTitle: title, withBody: nil)
                
                // then
                XCTAssertFalse(postService.changePostBodyCalled)
                XCTAssertTrue(postService.changePostTitleCalled)
                XCTAssertFalse(postService.changePostTitleAndBodyCalled)
                XCTAssertFalse(presenter.encounteredErrorCalled)
                XCTAssertTrue(presenter.postChangedCalled)
                return Promise()
            }.catch { error in
                XCTFail("shouldn't be here")
                interactor.output?.encounteredError(error: error)
            }
        } else if body != nil {
            XCTFail("shouldn't be here")
        }
    }
    
    func testChangePostWithTitleAndWhithoutBodyWithErrorResponse() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let interactor = presenter.interactor as? MockPostInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("presenter and interactor shouldn't be nil")
            return
        }
        let title: String? = "title"
        let body: String? = nil
        postService.changePostTitleWithError = true
        // when
        if let _ = title, let _ = body {
            XCTFail("shouldn't be here")
        } else if let title = title {
            firstly {
                interactor.postService.changePostTitle(1, title: title)
            }.then { _ -> Promise<Void> in
                XCTFail("shouldn't be here")
                interactor.output?.postChanged(withTitle: title, withBody: nil)
                return Promise()
            }.catch { error in
                interactor.output?.encounteredError(error: error)
                
                // then
                XCTAssertFalse(postService.changePostBodyCalled)
                XCTAssertTrue(postService.changePostTitleCalled)
                XCTAssertFalse(postService.changePostTitleAndBodyCalled)
                XCTAssertTrue(presenter.encounteredErrorCalled)
                XCTAssertFalse(presenter.postChangedCalled)
            }
        } else if body != nil {
            XCTFail("shouldn't be here")
        }
    }
    
    func testChangePostWithoutTitleAndWithBodyWithoutErrorResponse() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let interactor = presenter.interactor as? MockPostInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("presenter and interactor shouldn't be nil")
            return
        }
        let title: String? = nil
        let body: String? = "body"
        postService.changePostBodyWithError = false
        // when
        if let _ = title, let _ = body {
            XCTFail("shouldn't be here")
        } else if title != nil {
            XCTFail("shouldn't be here")
        } else if let body = body {
            firstly {
                interactor.postService.changePostBody(1, body: body)
            }.then { _  -> Promise<Void> in
                interactor.output?.postChanged(withTitle: nil, withBody: body)
                
                // then
                XCTAssertTrue(postService.changePostBodyCalled)
                XCTAssertFalse(postService.changePostTitleCalled)
                XCTAssertFalse(postService.changePostTitleAndBodyCalled)
                XCTAssertFalse(presenter.encounteredErrorCalled)
                XCTAssertTrue(presenter.postChangedCalled)
                
                return Promise()
            }.catch { error in
                XCTFail("shouldn't be here")
                interactor.output?.encounteredError(error: error)
            }
        }
        
    }
    
    func testChangePostWithoutTitleAndWithBodyWithErrorResponse() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let interactor = presenter.interactor as? MockPostInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("presenter and interactor shouldn't be nil")
            return
        }
        let title: String? = nil
        let body: String? = "body"
        postService.changePostBodyWithError = true
        // when
        if let _ = title, let _ = body {
            XCTFail("shouldn't be here")
        } else if title != nil {
            XCTFail("shouldn't be here")
        } else if let body = body {
            firstly {
                interactor.postService.changePostBody(1, body: body)
            }.then { _  -> Promise<Void> in
                XCTFail("shouldn't be here")
                interactor.output?.postChanged(withTitle: nil, withBody: body)
                
                return Promise()
            }.catch { error in
                interactor.output?.encounteredError(error: error)
                
                // then
                XCTAssertTrue(postService.changePostBodyCalled)
                XCTAssertFalse(postService.changePostTitleCalled)
                XCTAssertFalse(postService.changePostTitleAndBodyCalled)
                XCTAssertTrue(presenter.encounteredErrorCalled)
                XCTAssertFalse(presenter.postChangedCalled)
            }
        }
        
    }
    
    func testChangePostWithTitleAndBodyWithoutErrorResponse() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let interactor = presenter.interactor as? MockPostInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("presenter and interactor shouldn't be nil")
            return
        }
        let title: String? = "title"
        let body: String? = "body"
        postService.changePostTitleAndBodyWithError = false
        // when
        if let title = title, let body = body {
            firstly {
                interactor.postService.changePostTitleAndBody(1, title: title, body: body)
            }.then { _  -> Promise<Void> in
                interactor.output?.postChanged(withTitle: title, withBody: body)
                
                // then
                XCTAssertFalse(postService.changePostBodyCalled)
                XCTAssertFalse(postService.changePostTitleCalled)
                XCTAssertTrue(postService.changePostTitleAndBodyCalled)
                XCTAssertFalse(presenter.encounteredErrorCalled)
                XCTAssertTrue(presenter.postChangedCalled)
                
                return Promise()
            }.catch { error in
                XCTFail("shouldn't be here")
                interactor.output?.encounteredError(error: error)
            }
        } else if title != nil {
            XCTFail("shouldn't be here")
        } else if body != nil {
            XCTFail("shouldn't be here")
        }
    }
    
    func testChangePostWithTitleAndBodyWithErrorResponse() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let interactor = presenter.interactor as? MockPostInteractor,
            let postService = interactor.postService as? MockPostService
        else {
            XCTFail("presenter and interactor shouldn't be nil")
            return
        }
        let title: String? = "title"
        let body: String? = "body"
        postService.changePostTitleAndBodyWithError = true
        // when
        if let title = title, let body = body {
            firstly {
                interactor.postService.changePostTitleAndBody(1, title: title, body: body)
            }.then { _ -> Promise<Void> in
                XCTFail("shouldn't be here")
                interactor.output?.postChanged(withTitle: title, withBody: body)
                
                return Promise()
            }.catch { error in
                interactor.output?.encounteredError(error: error)
                
                // then
                XCTAssertFalse(postService.changePostBodyCalled)
                XCTAssertFalse(postService.changePostTitleCalled)
                XCTAssertTrue(postService.changePostTitleAndBodyCalled)
                XCTAssertTrue(presenter.encounteredErrorCalled)
                XCTAssertFalse(presenter.postChangedCalled)
            }
        } else if title != nil {
            XCTFail("shouldn't be here")
        } else if body != nil {
            XCTFail("shouldn't be here")
        }
        
    }
}
