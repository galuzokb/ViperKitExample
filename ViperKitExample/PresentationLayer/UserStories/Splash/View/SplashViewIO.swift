//
//  SplashViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/10/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

protocol SplashViewInput: class, ViewInput {
}

protocol SplashViewOutput {
    func viewIsReady()
    func viewAppeared()
}
