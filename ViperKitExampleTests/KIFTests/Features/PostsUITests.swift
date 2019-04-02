//
//  PostsUITests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/18/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

/*
 Test cases:
 onLoad:
    - PKHUD is showing
 didLoad:
    - PKHUD disappeared
    - Logout is enabled
    - table view has all cells?
 Create post is enabled:
    - load fake 100- posts
    - create posts is enabled
 create post is disabled:
    - load fake 100 posts
    - create post is disabled
 on scroll down:
    - refresh table view indicator appeared
 on didUpdated:
    - refresh tableView indicator disappeared
    - table view reloaded
 on scroll up:
    - cells loaded?
 on logout tap:
    - sign in opened
 post deleted:
    - post cell removed
    - create post is enabled
 on edit tap:
    - text edit opened
*/

class PostsUITests: BaseUITests {
    override func beforeAll() {
        super.beforeAll()
    }
    
    override func beforeEach() {
        super.beforeEach()
        login()
        backToRoot()
        waitForSplash()
    }
    
    //initial load finished
    func testOnInitialPostLoadFinished() {
        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.CommonAccessibilityLabels.PKHUDView)
        tester().waitForTappableView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.logoutBtn)
//        tester().waitForTappableView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.createPostBtn)
        tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.tableView)
    }
    
    func testLogotutTap() {
        tapLogout()
        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.backgroundView)
        tester().waitForView(withAccessibilityLabel: UIConstants.SigninAccessibilityLabels.backgroundView)
    }
    
//    func testCreatePostTap() {
//        tapCreatePost()
//        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.backgroundView)
//        tester().waitForView(withAccessibilityLabel: UIConstants.PostAccessibilityLabels.backgroundView)
//    }
    
    func testEditBtnTap() {
        tapEditBtn()
        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.backgroundView)
        tester().waitForView(withAccessibilityLabel: UIConstants.EditTextAccessibilityLabels.backgroundView)
    }
    
    func testRefreshData() {
        scrollToTop()
        tester().swipeView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.tableView, in: .down)
        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.refreshControl)
    }
}
