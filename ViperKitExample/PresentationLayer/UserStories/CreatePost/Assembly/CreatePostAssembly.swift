//
//  CreatePostCreatePostAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit
import UIKit

class CreatePostModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { CreatePostViewController() }
            .implements(CreatePostViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as CreatePostModuleInput
            }
        
        container.register { CreatePostPresenter(interactor: $0, router: $1) }
            .implements(CreatePostModuleInput.self, CreatePostViewOutput.self, CreatePostInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
            }
        
        container.register { CreatePostRouter() }
            .implements(CreatePostRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
            }
        
        container.register { CreatePostInteractor() }
            .implements(CreatePostInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
            }
    }
}

extension CreatePostViewController: StoryboardInstantiatable {}