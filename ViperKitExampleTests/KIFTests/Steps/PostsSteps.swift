//
//  PostsSteps.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/18/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import KIF
@testable import ViperKitExample

extension PostsUITests {
    func tapLogout() {
        tapButton(UIConstants.PostsAccessibilityLabels.logoutBtn)
    }
    
    func tapCreatePost() {
        tapButton(UIConstants.PostsAccessibilityLabels.createPostBtn)
    }
    
    func tapEditBtn() {
        tapButton(UIConstants.PostsAccessibilityLabels.editBtn)
    }
    
    func scrollToTop() {
        let tableView = tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.tableView) as! UITableView
        tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView, at: .top)
    }
}
