//
//  CommonSteps.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/18/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

@testable import ViperKitExample

extension BaseUITests {
    
    func waitForSplash() {
        //tester().waitForView(withAccessibilityLabel: UIConstants.SplashAccessibilityLabels.backgroundView)
        //        tester().waitForView(withAccessibilityLabel: UIConstants.SigninAccessibilityLabels.backgroundView)
        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.SplashAccessibilityLabels.backgroundView)
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "com.galuzokb.ViperKitExample.isAuthorized")
    }
    
    func backToRoot() {
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            navigationController.popToRootViewController(animated: false)
        } else {
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    func login() {
        UserDefaults.standard.set(true, forKey: "com.galuzokb.ViperKitExample.isAuthorized")
    }
    
    func tapButton(_ buttonName: String) {
        tester().tapView(withAccessibilityLabel: buttonName)
    }
    
    func expectToSeeAlert(with message: String) {
        tester().waitForView(withAccessibilityLabel: message)
    }
    
    func fillIn(_ accessibilityLabel: String, withText text: String) {
        tester().clearText(fromAndThenEnterText: text, intoViewWithAccessibilityLabel: accessibilityLabel)
    }
    
    func waitForPostsLoaded() {
        tester().waitForAbsenceOfView(withAccessibilityLabel: UIConstants.CommonAccessibilityLabels.PKHUDView)
        tester().waitForView(withAccessibilityLabel: UIConstants.PostsAccessibilityLabels.tableView)
    }
    
    func openSearchTab() {
        tapButton(UIConstants.SearchAccessibilityLabels.tabBarItem)
    }
    
    func openPostsTab() {
        tapButton(UIConstants.PostsAccessibilityLabels.tabBarItem)
    }
}
