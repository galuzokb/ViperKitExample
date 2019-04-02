//
//  SearchSteps.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/26/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import KIF

extension SearchUITests {    
    func enterSearchRequest(_ text: String) {
        tester().clearText(fromAndThenEnterText: text, intoViewWithAccessibilityLabel: UIConstants.SearchAccessibilityLabels.searchBar)
    }
    
    func waitForSearchComplete() {
        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.CommonAccessibilityLabels.PKHUDView)
    }
    
    func openPost() {
        tester().waitForView(withAccessibilityLabel: UIConstants.SearchAccessibilityLabels.tableView)
//        tester().waitForCell(at: IndexPath(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: UIConstants.SearchAccessibilityLabels.tableView).tap()
        tester().tapRow(at: IndexPath(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: UIConstants.SearchAccessibilityLabels.tableView)
    }
}
