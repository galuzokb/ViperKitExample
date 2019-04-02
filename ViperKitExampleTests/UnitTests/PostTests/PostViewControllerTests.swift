//
//  PostViewControllerTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostViewControllerTests: PostBaseTests {
    
    func testViewDidLoad() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        // when
        viewController.output.viewIsReady()
        // then
        XCTAssertTrue(presenter.viewIsReadyCalled, "viewIsReady() should be called")
    }
    
    func testDone() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let title = "title"
        let body = "body"
        // when
        viewController.output.done(title: title, body: body)
        // then
        XCTAssertTrue(presenter.doneCalled, "done(..,..) should be called")
    }
    
    func testBack() {
        // given
        guard let presenter = viewController.output as? MockPostPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        // when
        viewController.output.back()
        // then
        XCTAssertTrue(presenter.backCalled, "back() should be called")
    }
    
    func testSetupIntialState() {
        // given
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        viewController.doneBtn = doneBtn
        // when
        viewController.doneBtn.isEnabled = false
        // then
        XCTAssertFalse(doneBtn.isEnabled, "it should be disabled")
    }
    
    func testSetupPost() {
        // given
        let postIDLbl = UILabel(frame: .zero)
        let userIDLbl = UILabel(frame: .zero)
        let titleTV = UITextView(frame: .zero)
        let bodyTV = UITextView(frame: .zero)
        
        viewController.postIDLbl = postIDLbl
        viewController.userIDLbl = userIDLbl
        viewController.titleTV = titleTV
        viewController.bodyTV = bodyTV
        
        let id = 1
        let userID = 1
        let title = "title"
        let body = "body"
        let post = Post(id: id, userID: userID, title: title, body: body)
        // when
        viewController.postIDLbl.text = post.id.description
        viewController.userIDLbl.text = post.userID?.description
        viewController.titleTV.text = post.title
        viewController.bodyTV.text = post.body
        // then
        XCTAssertEqual(postIDLbl.text, id.description)
        XCTAssertEqual(userIDLbl.text, userID.description)
        XCTAssertEqual(titleTV.text, title)
        XCTAssertEqual(bodyTV.text, body)
    }
    
    func testSetDoneBtnState() {
        // given
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        doneBtn.isEnabled = true
        let state = false
        viewController.doneBtn = doneBtn
        // when
        viewController.doneBtn.isEnabled = state
        // then
        XCTAssertEqual(doneBtn.isEnabled, state)
    }
}
