//
//  AuthorizationService.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation

enum AuthErrorType {
    case wrongUsername
    case wrongPassword
    case wrongCredentials
}

class AuthorizationService: AuthorizationServiceType {
    
    let userDefaults = UserDefaults.standard
    let validCredentials = SigninCredentials(username: "correctUsername", password: "correctPassword")
    
    var isAuthorized: Bool {
        return userDefaults.bool(forKey: "com.galuzokb.ViperKitExample.isAuthorized")
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
            userDefaults.set(true, forKey: "com.galuzokb.ViperKitExample.isAuthorized")
            return nil
        }
    }
    
    func logout() {
        userDefaults.removeObject(forKey: "com.galuzokb.ViperKitExample.isAuthorized")
    }
}
