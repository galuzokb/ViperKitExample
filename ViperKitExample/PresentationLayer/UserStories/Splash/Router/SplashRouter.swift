//
//  SplashRouter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

class SplashRouter: SplashRouterInput {
    weak var segueHandler: SegueHandler?
    
    func openMain() {
        segueHandler?.openModule(segueIdentifier: "main")
    }
    
    func openSignin() {
        segueHandler?.openModule(segueIdentifier: "signin")
    }
}
