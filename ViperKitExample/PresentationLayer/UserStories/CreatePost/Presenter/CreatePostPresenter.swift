//
//  CreatePostCreatePostPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class CreatePostPresenter {
    weak var view: CreatePostViewInput?
    let interactor: CreatePostInteractorInput
    let router: CreatePostRouterInput
    
    init(interactor: CreatePostInteractorInput, router: CreatePostRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension CreatePostPresenter: CreatePostModuleInput {
    
}

//MARK: - View output

extension CreatePostPresenter: CreatePostViewOutput {
    func viewIsReady() {
    }
}

//MARK: - Interactor output

extension CreatePostPresenter: CreatePostInteractorOutput {
    
}