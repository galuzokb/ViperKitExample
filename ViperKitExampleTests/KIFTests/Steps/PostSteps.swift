//
//  PostSteps.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/22/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

extension PostUITests {
    func openFirstPost() {
        tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.tableView)
//        let cell = tester().waitForCell(at: IndexPath(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: UIConstants.PostsAccessibilityLabels.tableView)
        tester().tapRow(at: IndexPath(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: UIConstants.PostsAccessibilityLabels.tableView)
    }
    
    func backToPosts() {
        tapButton(UIConstants.PostAccessibilityLabels.backBtn)
    }
    
    func done() {
        tapButton(UIConstants.PostAccessibilityLabels.doneBtn)
    }
    
    func enterNewTitle() {
        tester().clearText(fromAndThenEnterText: "New Post Title", intoViewWithAccessibilityLabel: UIConstants.PostAccessibilityLabels.titleTV)
    }
}
