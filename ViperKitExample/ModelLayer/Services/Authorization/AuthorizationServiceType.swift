//
//  AuthorizationServiceType.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation

protocol AuthorizationServiceType {
    var isAuthorized: Bool { get }
    func signin(_ credentials: SigninCredentials) -> AuthErrorType?
    func logout()
}
