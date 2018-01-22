//
//  FirstPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 18/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class FirstPresenter {
    weak var view: FirstViewInput?
    let interactor: FirstInteractorInput
    let router: FirstRouterInput
    
    init(interactor: FirstInteractorInput, router: FirstRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension FirstPresenter: FirstModuleInput {
    
}

//MARK: - View output

extension FirstPresenter: FirstViewOutput {
    func viewIsReady() {
    }
}

//MARK: - Interactor output

extension FirstPresenter: FirstInteractorOutput {
    
}