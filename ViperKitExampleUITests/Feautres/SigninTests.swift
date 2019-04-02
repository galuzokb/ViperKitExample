//
//  SigninTests.swift
//  ViperKitExampleUITests
//
//  Created by Kirill Galuzo on 6/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//
/*
class SigninTests: BaseUITests {
    
    override func beforeEach() {
        super.beforeEach()
        backToRoot()
        clearUsernameAndPasswordFields()
    }
    
    func testEmptyUserName() {
        tapButton(UIConstants.SigninAccessibilityLabels.signinBtn)
        expectToSeeAlert(with: UIConstants.SigninAlertLabels.wrongUsername)
        tapButton("OK")
    }
    
    func testEmptyPassword() {
        fillCorrectUsername()
        expectToSeeAlert(with: UIConstants.SigninAlertLabels.wrongPassword)
        tapButton("OK")
    }
    
    func testWrongUserName() {
        fillWrongUsername()
        fillCorrectPassword()
        tapButton(UIConstants.SigninAccessibilityLabels.signinBtn)
        expectToSeeAlert(with: UIConstants.SigninAlertLabels.wrongUsername)
        tapButton("OK")
    }
    
    func testWrongPassword() {
        fillCorrectUsername()
        fillWrongPassword()
        tapButton(UIConstants.SigninAccessibilityLabels.signinBtn)
        expectToSeeAlert(with: UIConstants.SigninAlertLabels.wrongPassword)
        tapButton("OK")
    }
    
    func testWrongUsernameAndPassword() {
        fillWrongUsername()
        fillWrongPassword()
        tapButton("OK")
        expectToSeeAlert(with: UIConstants.SigninAlertLabels.wrongCredentials)
        tapButton("OK")
    }
    
    func testCorrectUserNameAndPassword() {
        fillCorrectUsername()
        fillCorrectPassword()
        tapButton("OK")
        expectToGoToMainScreen()
    }
}
*/
