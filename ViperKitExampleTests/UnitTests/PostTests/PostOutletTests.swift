//
//  PostOutletTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostOutletTests: XCTestCase {
    
    var postViewController: PostViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        postViewController = storyboard.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController
        let navigationController = UINavigationController(rootViewController: postViewController)
        let _ = postViewController.view
    }
    
    override func tearDown() {
        postViewController = nil
        
        super.tearDown()
    }
    
    func testOutletsSetup() {
        XCTAssertNotNil(postViewController.postIDLbl)
        XCTAssertNotNil(postViewController.userIDLbl)
        XCTAssertNotNil(postViewController.titleTV)
        XCTAssertNotNil(postViewController.bodyTV)
        XCTAssertNotNil(postViewController.doneBtn)
    }
    
    func testSetupPost() {
        // given
        let idLbl = postViewController.postIDLbl
        let userIDLbl = postViewController.userIDLbl
        let titleTV = postViewController.titleTV
        let bodyTV = postViewController.bodyTV
        
        let id = "1"
        let userID = "1"
        let title = "title"
        let body = "body"
        // when
        postViewController.postIDLbl.text = id
        postViewController.userIDLbl.text = userID
        postViewController.titleTV.text = title
        postViewController.bodyTV.text = body
        // then
        XCTAssertEqual(idLbl?.text, id)
        XCTAssertEqual(userIDLbl?.text, userID)
        XCTAssertEqual(titleTV?.text, title)
        XCTAssertEqual(bodyTV?.text, body)
    }
    
    func testSetDonBtnState() {
        // given
        let doneBtn = postViewController.doneBtn
        doneBtn?.isEnabled = true
        let state = false
        // when
        postViewController.doneBtn.isEnabled = state
        // then
        XCTAssertEqual(doneBtn?.isEnabled, state)
    }
}
