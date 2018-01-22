//
//  SigninInteractor.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

class SigninInteractor: SigninInteractorInput {
    weak var output: SigninInteractorOutput?
    
    //MARK: - Services
    let service: AuthorizationServiceType
    
    init(service: AuthorizationServiceType) {
        self.service = service
    }
    
    func signin(withCredentials credentials: SigninCredentials) {
        if service.signin(credentials) {
            output?.success()
        } else {
            output?.failure()
        }
    }
}
