//
//  SecondPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 18/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class SecondPresenter {
    weak var view: SecondViewInput?
    let interactor: SecondInteractorInput
    let router: SecondRouterInput
    
    init(interactor: SecondInteractorInput, router: SecondRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension SecondPresenter: SecondModuleInput {
    
}

//MARK: - View output

extension SecondPresenter: SecondViewOutput {
    func viewIsReady() {
    }
}

//MARK: - Interactor output

extension SecondPresenter: SecondInteractorOutput {
    
}