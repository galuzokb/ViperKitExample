//
//  SigninInteractorIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

//MARK: - Interactor input

protocol SigninInteractorInput {
    func signin(withCredentials credentials: SigninCredentials)
}

//MARK: - Interactor Output

protocol SigninInteractorOutput: class {
    func success()
    func failure()
}
