//
//  PostUITests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/22/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import KIF
@testable import ViperKitExample

class PostUITests: BaseUITests {
    
    override func beforeAll() {
        super.beforeAll()
    }
    
    override func beforeEach() {
        super.beforeEach()
        login()
        backToRoot()
        waitForSplash()
        waitForPostsLoaded()
        openFirstPost()
    }
    
    func testDataInViews() {
        let postIDLbl = tester().waitForView(withAccessibilityLabel: UIConstants.PostAccessibilityLabels.postIDLbl)!
        tester().expect(postIDLbl, toContainText: "1")
        let userIDLbl = tester().waitForView(withAccessibilityLabel: UIConstants.PostAccessibilityLabels.userIDLbl)!
        tester().expect(userIDLbl, toContainText: "1")
        //TODO: removing next steps until mocked network request unimplemented
//        let titleTV = tester().waitForView(withAccessibilityLabel: UIConstants.PostAccessibilityLabels.titleTV)!
//        tester().expect(titleTV, toContainText: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
//        let bodyTV = tester().waitForView(withAccessibilityLabel: UIConstants.PostAccessibilityLabels.bodyTV)!
//        tester().expect(bodyTV, toContainText: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    }
    
    func testBack() {
        backToPosts()
        tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.backgroundView)
    }
    
    func testDone() {
        enterNewTitle()
        done()
        let cell = tester().waitForCell(at: IndexPath(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: UIConstants.PostsAccessibilityLabels.tableView) as! PostsTableViewCell
        XCTAssert(cell.titleLbl.text! == "New Post Title", "!!!")
    }
}
