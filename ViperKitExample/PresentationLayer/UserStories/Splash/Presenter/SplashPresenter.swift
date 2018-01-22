//
//  SplashPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

class SplashPresenter {
    weak var view: SplashViewInput?
    let interactor: SplashInteractorInput
    let router: SplashRouterInput
    
    init(interactor: SplashInteractorInput, router: SplashRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension SplashPresenter: SplashModuleInput {
    
}

//MARK: - View output

extension SplashPresenter: SplashViewOutput {
    func viewIsReady() {
    }
    
    func viewAppeared() {
        if interactor.isAuthorized() {
            router.openMain()
        } else {
            router.openSignin()
        }
    }
}

//MARK: - Interactor output

extension SplashPresenter: SplashInteractorOutput {
    
}
