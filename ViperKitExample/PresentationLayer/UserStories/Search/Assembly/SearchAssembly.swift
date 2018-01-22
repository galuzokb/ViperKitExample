//
//  SearchAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit
import UIKit

class SearchModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { SearchViewController() }
            .implements(SearchViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as SearchModuleInput
            }
        
        container.register { SearchPresenter(interactor: $0, router: $1) }
            .implements(SearchModuleInput.self, SearchViewOutput.self, SearchInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
            }
        
        container.register { SearchRouter() }
            .implements(SearchRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
            }
        
        container.register { SearchInteractor(postService: $0) }
            .implements(SearchInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
            }
    }
}

extension SearchViewController: StoryboardInstantiatable {}
