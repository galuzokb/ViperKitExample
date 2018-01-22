//
//  AuthorizationService.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation

class AuthorizationService: AuthorizationServiceType {
    
    let userDefaults = UserDefaults.standard
    let validCredentials = SigninCredentials(username: "qwe", password: "123")
    
    var isAuthorized: Bool {
        return userDefaults.bool(forKey: "com.galuzokb.ViperKitExample.isAuthorized")
    }
    
    func signin(_ credentials: SigninCredentials) -> Bool {
        if credentials.username == "qwe" && credentials.password == "123" {
            userDefaults.set(true, forKey: "com.galuzokb.ViperKitExample.isAuthorized")
            return true
        }
        return false
    }
    
    func logout() {
        userDefaults.removeObject(forKey: "com.galuzokb.ViperKitExample.isAuthorized")
    }
}
