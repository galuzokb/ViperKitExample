//
//  SigninPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ViperKit

class SigninPresenter {
    weak var view: SigninViewInput?
    let router: SigninRouterInput
    let interactor: SigninInteractorInput
    
    init(interactor: SigninInteractorInput, router: SigninRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension SigninPresenter: SigninModuleInput {}

//MARK: - View output

extension SigninPresenter: SigninViewOutput {
    
    func viewIsReady() {
        view?.setupInitialState()
    }
    
    func onSignin(username: String?, password: String?) {
        guard let username = username else {
            view?.showError(message: "Please, enter username!")
            return
        }
        
        guard let password = password else {
            view?.showError(message: "Please, enter password!")
            return
        }
        
        interactor.signin(withCredentials: SigninCredentials(username: username, password: password))
    }
}

//MARK: - Interactor output

extension SigninPresenter: SigninInteractorOutput {
    func success() {
        router.openMain()
    }
    
    func failure(_ authError: AuthErrorType) {
        switch authError {
        case .wrongUsername:
            view?.showError(message: "Wrong username!")
        case .wrongPassword:
            view?.showError(message: "Wrong password!")
        case .wrongCredentials:
            view?.showError(message: "Wrong credentials!")
        }
    }
}
