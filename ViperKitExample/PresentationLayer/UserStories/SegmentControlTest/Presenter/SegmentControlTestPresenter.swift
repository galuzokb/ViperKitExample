//
//  SegmentControlTestPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class SegmentControlTestPresenter {
    weak var view: SegmentControlTestViewInput?
    let interactor: SegmentControlTestInteractorInput
    let router: SegmentControlTestRouterInput
    
    init(interactor: SegmentControlTestInteractorInput, router: SegmentControlTestRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension SegmentControlTestPresenter: SegmentControlTestModuleInput {
    
}

//MARK: - View output

extension SegmentControlTestPresenter: SegmentControlTestViewOutput {
    func viewIsReady() {
        view?.setupInitialState()
    }
}

//MARK: - Interactor output

extension SegmentControlTestPresenter: SegmentControlTestInteractorOutput {
    
}
