////
////  CreatePostMocks.swift
////  ViperKitExampleTests
////
////  Created by Kirill Galuzo on 7/6/18.
////  Copyright © 2018 galuzokb. All rights reserved.
////
//
//import Foundation
//import ViperKit
//import Dip
//import Dip_UI
//@testable import ViperKitExample
//
//// MARK: - Assembly Mocks
//
//class MockCreatePostAssembliesFactory: AssembliesFactory {
//    override func registerServicesLayer(root: RootServicesAssembly) {
//        container.register(.eagerSingleton) { MockServicesAssembly(withCollaborator: $0) }
//    }
//    override func registerPresentationLayer(root: RootViperAssembly) {
//        container.register(.eagerSingleton) { MockCreatePostModuleAssembly(withCollaborator: $0) }
//    }
//}
//
//class MockCreatePostModuleAssembly: BaseViperAssembly {
//    let tag: String? = nil
//
//    override init(withCollaborator collaborator: RootViperAssembly) {
//        super.init(withCollaborator: collaborator)
//
//        container.register(tag: nil) { MockCreatePostViewController() }
//            .implements(CreatePostViewInput.self, SegueHandler.self)
//            .resolvingProperties { (container, controller) in
//                controller.output = try container.resolve()
//                controller.moduleInput = try container.resolve() as CreatePostModuleInput
//        }
//
//        container.register { MockCreatePostPresenter(interactor: $0, router: $1) }
//            .implements(CreatePostModuleInput.self, CreatePostViewOutput.self, CreatePostInteractorOutput.self)
//            .resolvingProperties { [unowned self] (container, presenter) in
//                presenter.view = try container.resolve(tag: self.tag)
//        }
//
//        container.register { MockCreatePostRouter() }
//            .implements(CreatePostRouterInput.self)
//            .resolvingProperties { [unowned self] (container, router) in
//                router.segueHandler = try container.resolve(tag: self.tag)
//        }
//
//        container.register { MockCreatePostInteractor(postService: $0) }
//            .implements(CreatePostInteractorInput.self)
//            .resolvingProperties { (container, interactor) in
//                interactor.output = try container.resolve()
//        }
//    }
//}
//
//extension MockCreatePostViewController: StoryboardInstantiatable {}
//
//// MARK: - View Controller Mocks
//
//class MockCreatePostViewController: MockBaseViewController {
//    var output: CreatePostViewOutput!
//    var moduleInput: ModuleInput!
//
//
//}
//
//// MARK: - Presenter Mocks
//
//class MockCreatePostPresenter {
//    weak var view: CreatePostViewInput?
//    let interactor: CreatePostInteractorInput
//    let router: CreatePostRouterInput
//
//    init(interactor: CreatePostInteractorInput, router: CreatePostRouterInput) {
//        self.interactor = interactor
//        self.router = router
//    }
//}
//
//extension MockCreatePostPresenter: CreatePostModuleInput {
//
//}
//
//extension MockCreatePostPresenter: CreatePostInteractorOutput {
//
//}
//
//// MARK: - Interactor Mocks
//
//
//// MARK: - Router Mocks
