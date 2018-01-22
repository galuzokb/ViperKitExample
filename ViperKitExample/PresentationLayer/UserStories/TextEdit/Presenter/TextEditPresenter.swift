//
//  TextEditTextEditPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class TextEditPresenter {
    weak var view: TextEditViewInput?
    let interactor: TextEditInteractorInput
    let router: TextEditRouterInput
    var output: TextEditModuleOutput?
    
    var text: String?
    
    init(interactor: TextEditInteractorInput, router: TextEditRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension TextEditPresenter: TextEditModuleInput {
    func setModuleOutput(_ output: TextEditModuleOutput) {
        self.output = output
    }
    
    func setText(_ text: String?) {
        self.text = text
    }
}

//MARK: - View output

extension TextEditPresenter: TextEditViewOutput {
    func viewIsReady() {
        view?.setText(self.text)
    }
    
    func cancel() {
        router.close()
    }
    
    func done(_ text: String?) {
        output?.textChanged(text)
        router.close()
    }
}

//MARK: - Interactor output

extension TextEditPresenter: TextEditInteractorOutput {
    
}
