//
//  SigninUITests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/18/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

class SigninUITests: BaseUITests {
    
    //log out, then go to splash, wait splash disappears, clear all textfields
    override func beforeEach() {
        super.beforeEach()
        logOut()
        backToRoot()
        waitForSplash()
        clearUsernameAndPasswordFields()
    }
    
    func testEmptyUserName() {
        tapButton(UIConstants.SigninAccessibilityLabels.signinBtn)
        expectToSeeAlert(with: UIConstants.SigninAlertLabels.wrongCredentials)
        tapButton("OK")
    }
    
    func testEmptyPassword() {
        fillCorrectUsername()
        tapButton(UIConstants.SigninAccessibilityLabels.signinBtn)
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
        tapButton(UIConstants.SigninAccessibilityLabels.signinBtn)
        expectToSeeAlert(with: UIConstants.SigninAlertLabels.wrongCredentials)
        tapButton("OK")
    }
    
    func testCorrectUserNameAndPassword() {
        fillCorrectUsername()
        fillCorrectPassword()
        tapButton(UIConstants.SigninAccessibilityLabels.signinBtn)
        expectToGoToMainScreen()
    }
}

