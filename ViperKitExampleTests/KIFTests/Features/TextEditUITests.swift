//
//  TextEditUITests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/21/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

class TextEditUITests: BaseUITests {
    
    override func beforeAll() {
        super.beforeAll()
    }
    
    override func beforeEach() {
        super.beforeEach()
        login()
        backToRoot()
        waitForSplash()
        visitTextEdit()
    }
    
    func testEnterNewText() {
        tester().clearText(fromAndThenEnterText: "New Text Here",
                           intoViewWithAccessibilityLabel: UIConstants.EditTextAccessibilityLabels.textView,
                           traits: UIAccessibilityTraitNone,
                           expectedResult: "New Text Here")
    }
    
    func testCancelTap() {
        let textLbl = enterNewTextAndTapButton(UIConstants.EditTextAccessibilityLabels.cancelBtn)
        tester().expect(textLbl, toContainText: "Old Text Here")
    }
    
    func testEditTextAndDoneBtnTap() {
        let textLbl = enterNewTextAndTapButton(UIConstants.EditTextAccessibilityLabels.doneBtn)
        tester().expect(textLbl, toContainText: "New Text Here")
    }
}
