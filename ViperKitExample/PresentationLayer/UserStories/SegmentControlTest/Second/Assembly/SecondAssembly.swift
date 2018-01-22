//
//  SecondAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 18/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit
import UIKit

class SecondModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { SecondViewController() }
            .implements(SecondViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as SecondModuleInput
            }
        
        container.register { SecondPresenter(interactor: $0, router: $1) }
            .implements(SecondModuleInput.self, SecondViewOutput.self, SecondInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
            }
        
        container.register { SecondRouter() }
            .implements(SecondRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
            }
        
        container.register { SecondInteractor() }
            .implements(SecondInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
            }
    }
}

extension SecondViewController: StoryboardInstantiatable {}