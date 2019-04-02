//
//  SearchUITests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/26/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import KIF

class SearchUITests: BaseUITests {
    
    override func beforeAll() {
        super.beforeAll()
    }
    
    override func beforeEach() {
        super.beforeEach()
        login()
        backToRoot()
        waitForSplash()
        waitForPostsLoaded()
        openSearchTab()
    }
    
    func testCorrectSearchRequest() {
        enterSearchRequest("1")
        tapButton("Search")
        //tester().waitForView(withAccessibilityLabel: UIConstants.CommonAccessibilityLabels.PKHUDView)
        waitForSearchComplete()
    }
    
    func testIncorrectSearchRequest() {
        enterSearchRequest("string")
        tapButton("Search")
        waitForSearchComplete()
        expectToSeeAlert(with: UIConstants.SearchAlertLabels.wrongSearchTerm)
        tapButton("OK")
    }
    
    func testOpenSearchedItemAfterCorrectSearch() {
        enterSearchRequest("1")
        tapButton("Search")
        waitForSearchComplete()
        openPost()
    }
    
    func testSwutchTabOnCorrectSearch() {
        enterSearchRequest("1")
        tapButton("Search")
        waitForSearchComplete()
        openPostsTab()
        tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.backgroundView)
        openSearchTab()
        tester().waitForView(withAccessibilityLabel: UIConstants.SearchAccessibilityLabels.tableView)
    }
    
    func testSwitchTabOnIncorrectSearch() {
        enterSearchRequest("string")
        tapButton("Search")
        waitForSearchComplete()
        expectToSeeAlert(with: UIConstants.SearchAlertLabels.wrongSearchTerm)
        tapButton("OK")
        openPostsTab()
        tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.backgroundView)
        openSearchTab()
        tester().waitForView(withAccessibilityLabel: UIConstants.SearchAccessibilityLabels.tableView)
    }
}
