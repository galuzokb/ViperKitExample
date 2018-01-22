//
//  SplashInteractor.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

class SplashInteractor: SplashInteractorInput {
    weak var output: SplashInteractorOutput?
    
    //MARK: - Services
    let userDefaults = UserDefaults.standard
    
    init() {}
    
    func isAuthorized() -> Bool {
        return userDefaults.bool(forKey: "com.galuzokb.ViperKitExample.isAuthorized")
    }
}
