//
//  EditTextSteps.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/21/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

extension TextEditUITests {
    func visitTextEdit() {
        tapButton(UIConstants.PostsAccessibilityLabels.editBtn)
    }
    
    func setDefaultTextOnPosts() {
        tester().clearText(fromAndThenEnterText: "Old Text Here", intoViewWithAccessibilityLabel: UIConstants.PostsAccessibilityLabels.textLbl)
    }
    
    func setDefaultTextOnTextEdit() {
        tester().clearText(fromAndThenEnterText: "Old Text Here", intoViewWithAccessibilityLabel: UIConstants.EditTextAccessibilityLabels.textView)
    }
    
    func enterNewTextAndTapButton(_ buttonName: String) -> UIView {
        tester().clearText(fromAndThenEnterText: "New Text Here", intoViewWithAccessibilityLabel: UIConstants.EditTextAccessibilityLabels.textView)
        tapButton(buttonName)
        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.EditTextAccessibilityLabels.backgroundView)
        tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.backgroundView)
        return tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.textLbl)
    }
}
