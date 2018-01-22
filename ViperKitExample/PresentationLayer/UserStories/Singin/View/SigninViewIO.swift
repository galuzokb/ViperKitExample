//
//  SigninViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

protocol SigninViewInput: class, ViewInput {
    func setupInitialState()
}

protocol SigninViewOutput {
    func viewIsReady()
    func onSignin(username: String?, password: String?)
}
