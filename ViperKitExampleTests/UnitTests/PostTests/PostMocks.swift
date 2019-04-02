//
//  PostMocks.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/3/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample
import ViperKit
import Dip
import Dip_UI

// MARK: - Assemblies Mock

class MockPostAssembliesFactory: AssembliesFactory {
    override func registerServicesLayer(root: RootServicesAssembly) {
        container.register(.eagerSingleton) { MockServicesAssembly(withCollaborator: $0) }
    }
    override func registerPresentationLayer(root: RootViperAssembly) {
        container.register(.eagerSingleton) { MockPostModuleAssembly(withCollaborator: $0) }
    }
}

class MockPostModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { MockPostViewController() }
            .implements(PostViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as PostModuleInput
        }
        
        container.register { MockPostPresenter(interactor: $0, router: $1) }
            .implements(PostModuleInput.self, PostViewOutput.self, PostInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
        }
        
        container.register { MockPostRouter() }
            .implements(PostRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
        }
        
        container.register { MockPostInteractor(postService: $0) }
            .implements(PostInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
        }
    }
}

extension MockPostViewController: StoryboardInstantiatable {}

// MARK: - View Controller Mock

class MockPostViewController: MockBaseViewController {
    var output: PostViewOutput!
    var moduleInput: ModuleInput!
    
    var postIDLbl: UILabel!
    var userIDLbl: UILabel!
    var titleTV: UITextView!
    var bodyTV: UITextView!
    var doneBtn: UIBarButtonItem!
    
    var setupInitialStateCalled = false
    var setupPostCalled = false
    var setDoneBtnStateCalled = false
}

extension MockPostViewController: PostViewInput {
    func setupInitialState() {
        setupInitialStateCalled = true
    }
    
    func setupPost(_ post: Post) {
        setupPostCalled = true
    }
    
    func setDoneBtnState(_ isEnabled: Bool) {
        setDoneBtnStateCalled = true
    }
}

extension MockPostViewController: ModuleInputProvider {}

// MARK: - Presenter Mock

class MockPostPresenter {
    weak var view: PostViewInput?
    let interactor: PostInteractorInput
    let router: PostRouterInput
    
    var postDidSet = false
    var outputDidSet = false
    
    var setPostCalled = false
    var setOutputCalled = false
    
    var viewIsReadyCalled = false
    var titleDidChangeCalled = false
    var bodyDidChangeCalled = false
    var doneCalled = false
    var backCalled = false
    
    var postChangedCalled = false
    var encounteredErrorCalled = false
    
    weak var output: PostModuleOutput? {
        didSet {
            outputDidSet = true
        }
    }
    
    var post: Post? = nil {
        didSet {
            postDidSet = true
        }
    }
    
    init(interactor: PostInteractorInput, router: PostRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension MockPostPresenter: PostModuleInput {
    func setPost(_ post: Post?) {
        setPostCalled = true
    }
    
    func setOutput(_ output: PostModuleOutput) {
        setOutputCalled = true
    }
}

extension MockPostPresenter: PostViewOutput {
    func viewIsReady() {
        viewIsReadyCalled = true
    }
    
    func titleDidChange(_ title: String) {
        titleDidChangeCalled = true
    }
    
    func bodyDidChange(_ body: String) {
        bodyDidChangeCalled = true
    }
    
    func done(title: String?, body: String?) {
        doneCalled = true
    }
    
    func back() {
        backCalled = true
    }
}

extension MockPostPresenter: PostInteractorOutput {
    func postChanged(withTitle title: String?, withBody body: String?) {
        postChangedCalled = true
    }
    
    func encounteredError(error: Error) {
        encounteredErrorCalled = true
    }
}

// MARK: - Interactor Mock

class MockPostInteractor: PostInteractorInput {
    var changePostCalled = false
    
    weak var output: PostInteractorOutput?
    
    let postService: PostServiceType!
    
    init(postService: PostServiceType) {
        self.postService = postService
    }
    
    func changePost(_ id: Int, title: String?, body: String?) {
        changePostCalled = true
    }
}

// MARK: - Router Mock

class MockPostRouter: PostRouterInput {
    var closeCalled = false
    
    weak var segueHandler: SegueHandler?
    
    func close() {
        closeCalled = true
    }
}
