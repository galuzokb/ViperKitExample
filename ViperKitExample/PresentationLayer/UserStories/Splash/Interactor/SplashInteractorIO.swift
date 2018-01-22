//
//  SplashInteractorIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

//MARK: - Interacor Input

protocol SplashInteractorInput {
    func isAuthorized() -> Bool
}

//MARK: - Interactor Output

protocol SplashInteractorOutput: class {
    
}
