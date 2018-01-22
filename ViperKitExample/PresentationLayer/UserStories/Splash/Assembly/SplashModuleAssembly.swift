//
//  SplashModuleAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit
import UIKit

class SplashModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { SplashViewController() }
            .implements(SplashViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as SplashModuleInput
            }
        
        container.register { SplashPresenter(interactor: $0, router: $1) }
            .implements(SplashModuleInput.self, SplashViewOutput.self, SplashInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
            }
        
        container.register { SplashRouter() }
            .implements(SplashRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
            }
        
        container.register { SplashInteractor() }
            .implements(SplashInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
            }
    }
}

extension SplashViewController: StoryboardInstantiatable {}
