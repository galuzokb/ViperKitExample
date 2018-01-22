//
//  PostsPostsAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 12/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit
import UIKit

class PostsModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { PostsViewController() }
            .implements(PostsViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as PostsModuleInput
            }
        
        container.register { PostsPresenter(interactor: $0, router: $1) }
            .implements(PostsModuleInput.self, PostsViewOutput.self, PostsInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
            }
        
        container.register { PostsRouter() }
            .implements(PostsRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
            }
        
        container.register { PostsInteractor(postService: $0, authService: $1) }
            .implements(PostsInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
            }
    }
}

extension PostsViewController: StoryboardInstantiatable {}
