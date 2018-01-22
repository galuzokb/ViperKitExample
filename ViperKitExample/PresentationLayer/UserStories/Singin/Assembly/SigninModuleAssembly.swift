//
//  SigninModuleAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit
import UIKit

class SigninModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { SigninViewController() }
            .implements(SigninViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as SigninModuleInput
        }
        
        container.register { SigninPresenter(interactor: $0, router: $1) }
            .implements(SigninModuleInput.self, SigninViewOutput.self, SigninInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
        }
        
        container.register { SigninRouter() }
            .implements(SigninRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
        }
        
        container.register { SigninInteractor(service: $0) }
            .implements(SigninInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
        }
    }
}

extension SigninViewController: StoryboardInstantiatable {}
