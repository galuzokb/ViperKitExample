//
//  EditTextMocks.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/3/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

@testable import ViperKitExample
import ViperKit
import Dip
import UIKit
import Dip_UI

// MARK: - Assemblies mock

class MockTextEditAssembliesFactory: AssembliesFactory {
    override func registerPresentationLayer(root: RootViperAssembly) {
        container.register(.eagerSingleton) { MockTextEditModuleAssembly(withCollaborator: $0) }
    }
}

class MockTextEditModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { MockTextEditViewController() }
            .implements(TextEditViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as TextEditModuleInput
        }
        
        container.register { MockTextEditPresenter(interactor: $0, router: $1) }
            .implements(TextEditModuleInput.self, TextEditViewOutput.self, TextEditInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
        }
        
        container.register { MockTextEditRouter() }
            .implements(TextEditRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
        }
        
        container.register { MockTextEditInteractor() }
            .implements(TextEditInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
        }
    }
}

extension MockTextEditViewController: StoryboardInstantiatable {}

// MARK: - View Controller Mock

class MockTextEditViewController: MockBaseViewController {
    var output: TextEditViewOutput!
    var moduleInput: ModuleInput!
    
    var textView: UITextView!
    
    var setTextCalled = false
}

extension MockTextEditViewController: TextEditViewInput {
    func setText(_ text: String?) {
        setTextCalled = true
    }
}

extension MockTextEditViewController: ModuleInputProvider {}

// MARK: - Presenter Mock

class MockTextEditPresenter {
    weak var view: TextEditViewInput?
    let interactor: TextEditInteractorInput
    let router: TextEditRouterInput
    var output: TextEditModuleOutput? {
        didSet {
            outputDidSet = true
        }
    }
    
    var outputDidSet = false
    var textDidSet = false
    var setTextCalled = false
    var setModuleOutputCalled = false
    var viewIsReadyCalled = false
    var cancelCalled = false
    var doneCalled = false
    
    var text: String? {
        didSet {
            textDidSet = true
        }
    }
    
    init(interactor: TextEditInteractorInput, router: TextEditRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension MockTextEditPresenter: TextEditModuleInput {
    func setText(_ text: String?) {
        setTextCalled = true
    }
    
    func setModuleOutput(_ output: TextEditModuleOutput) {
        setModuleOutputCalled = true
    }
}

extension MockTextEditPresenter: TextEditViewOutput {
    func viewIsReady() {
        viewIsReadyCalled = true
    }
    
    func cancel() {
        cancelCalled = true
    }
    
    func done(_ text: String?) {
        doneCalled = true
    }
}

extension MockTextEditPresenter: TextEditInteractorOutput {}

// MARK: - Router Mock

class MockTextEditRouter: TextEditRouterInput {
    weak var segueHandler: SegueHandler?
    
    var closeCalled = false
    
    func close() {
        closeCalled = true
    }
}

// MARK: - Interactor Mock

class MockTextEditInteractor: TextEditInteractorInput {
    weak var output: TextEditInteractorOutput?
    init() {}
}
