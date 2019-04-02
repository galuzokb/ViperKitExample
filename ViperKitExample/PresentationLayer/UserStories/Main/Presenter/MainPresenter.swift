//
//  MainPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class MainPresenter {
    weak var view: MainViewInput?
    let interactor: MainInteractorInput
    let router: MainRouterInput
    
    var indexToSelect: Int?
    var lastSelectedIndex: Int?
    
    init(interactor: MainInteractorInput, router: MainRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension MainPresenter: MainModuleInput {
    
}

//MARK: - View output

extension MainPresenter: MainViewOutput {
    func viewIsReady() {}
    
    func close() {
        router.close()
    }
    
    func shouldSelectIndex(_ index: Int) {
        if let lastSelectedIndex = lastSelectedIndex, lastSelectedIndex == 1 {
            view?.hideSearch()
        }
        lastSelectedIndex = index
        view?.selectedIndex(index)
    }
}

//MARK: - Interactor output

extension MainPresenter: MainInteractorOutput {
    
}
