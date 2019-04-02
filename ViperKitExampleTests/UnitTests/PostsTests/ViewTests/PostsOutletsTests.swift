//
//  PostsOutletsTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostsOutletsTests: XCTestCase {
    
    var postsViewController: PostsViewController!
    var cell: PostsTableViewCell!
    
    override func setUp() {
        super.setUp()
        
        let sb = UIStoryboard(name: "Posts", bundle: nil)
        postsViewController = sb.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        let _ = postsViewController.view
        postsViewController.displayManager = PostsDisplayManager(tableView: postsViewController.tableView)
    }
    
    override func tearDown() {
        postsViewController = nil
        super.tearDown()
    }
    
    // MARK: - Posts View Controller Tests
    
    func testViewControllerOutlets() {
        // given
        
        // when
        
        // then
        XCTAssertNotNil(postsViewController.createPostBtn, "shouldn't be nil")
        XCTAssertNotNil(postsViewController.tableView, "shouldn't be nil")
        XCTAssertNotNil(postsViewController.someTextLbl, "shouldn't be nil")
    }
    
    func testSetText() {
        // given
        let text = "New Text"
        // when
        postsViewController.someTextLbl.text = text
        // then
        XCTAssert(postsViewController.someTextLbl.text == "New Text")
    }
    
    func testCreatePostBtnStateEnabled() {
        // given
        let state = true
        // when
        postsViewController.createPostBtn.isEnabled = state
        // then
        XCTAssert(postsViewController.createPostBtn.isEnabled, "Should be enabled")
    }
    
    func testCreatePostBtnStateDisabled() {
        // given
        let state = false
        // when
        postsViewController.createPostBtn.isEnabled = state
        // then
        XCTAssert(!postsViewController.createPostBtn.isEnabled, "Should be disabled")
    }
    
    func testTableViewStopRefresh() {
        // given
        guard let refreshControl = postsViewController.tableView.refreshControl else {
            XCTFail()
            return
        }
        refreshControl.beginRefreshing()
        XCTAssert(refreshControl.isRefreshing)
        // when
        refreshControl.endRefreshing()
        // then
        XCTAssertNotNil(postsViewController.tableView.refreshControl)
        XCTAssert(!postsViewController.tableView.refreshControl!.isRefreshing)
    }
    
    // MARK: - Posts Table View Cell Tests
    
    func testCellOutlets() {
        let item = Post(id: 1, userID: 1, title: "title", body: "body")
        let indexPath = IndexPath(row: 0, section: 0)
        // when
        postsViewController.displayManager.items = [item]
        guard let cell = postsViewController.tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as? PostsTableViewCell else {
            XCTFail()
            return
        }
        // then
        XCTAssertNotNil(cell.idLbl, "Shouldn't be nil")
        XCTAssertNotNil(cell.titleLbl, "Shouldn't be nil")
    }
    
    func testSetItem() {
        // given
        let item = Post(id: 1, userID: 1, title: "title", body: "body")
        let indexPath = IndexPath(row: 0, section: 0)
        
        let id = "2"
        let title = "new title"
        
        postsViewController.displayManager.items = [item]
        guard let cell = postsViewController.tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as? PostsTableViewCell else {
            XCTFail()
            return
        }
        // when
        cell.idLbl.text = "2"
        cell.titleLbl.text = "new title"
        // then
        XCTAssertEqual(cell.idLbl.text, id, "id text should be set")
        XCTAssertEqual(cell.titleLbl.text, title, "id text should be set")
    }
}
