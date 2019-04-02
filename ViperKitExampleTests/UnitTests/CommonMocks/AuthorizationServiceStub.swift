//
//  AuthorizationServiceStub.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

@testable import ViperKitExample

class MockAuthorizationService: AuthorizationServiceType {
    var authorizedScenario = false
    var logoutCalled = false
    
    let validCredentials = SigninCredentials(username: "correctUsername", password: "correctPassword")
    
    var isAuthorized: Bool {
        get {
            return authorizedScenario
        }
    }
    
    func signin(_ credentials: SigninCredentials) -> AuthErrorType? {
        if credentials.username != validCredentials.username &&
            credentials.password != validCredentials.password {
            return .wrongCredentials
        } else if credentials.username != validCredentials.username {
            return .wrongUsername
        } else if credentials.password != validCredentials.password {
            return .wrongPassword
        } else {
            return nil
        }
    }
    
    func logout() {
        logoutCalled = true
    }
    
    
}
