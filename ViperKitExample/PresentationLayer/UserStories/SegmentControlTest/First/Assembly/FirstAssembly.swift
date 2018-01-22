//
//  FirstAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 18/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit
import UIKit

class FirstModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { FirstViewController() }
            .implements(FirstViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as FirstModuleInput
            }
        
        container.register { FirstPresenter(interactor: $0, router: $1) }
            .implements(FirstModuleInput.self, FirstViewOutput.self, FirstInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
            }
        
        container.register { FirstRouter() }
            .implements(FirstRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
            }
        
        container.register { FirstInteractor() }
            .implements(FirstInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
            }
    }
}

extension FirstViewController: StoryboardInstantiatable {}