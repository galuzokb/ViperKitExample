//
//  SigninMocks.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/29/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

@testable import ViperKitExample
import ViperKit
import Dip
import UIKit
import Dip_UI

// MARK: - Assemblies mock

class MockSigninAssembliesFactory: AssembliesFactory {
    override func registerServicesLayer(root: RootServicesAssembly) {
        container.register(.eagerSingleton) { MockServicesAssembly(withCollaborator: $0) }
    }
    override func registerPresentationLayer(root: RootViperAssembly) {
        container.register(.eagerSingleton) { MockSigninModuleAssembly(withCollaborator: $0) }
    }
}

class MockSigninModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { MockSigninViewController() }
            .implements(SigninViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as SigninModuleInput
        }
        
        container.register { MockSigninPresenter(interactor: $0, router: $1) }
            .implements(SigninModuleInput.self, SigninViewOutput.self, SigninInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
        }
        
        container.register { MockSigninRouter() }
            .implements(SigninRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
        }
        
        container.register { MockSigninInteractor(service: $0) }
            .implements(SigninInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
        }
    }
}

//extension MockSigninViewController: StoryboardInstantiatable {}

// MARK: - Signin View Controller Mock

class MockSigninViewController: SigninViewController {//MockBaseViewController {
//    var output: SigninViewOutput!
//    var moduleInput: ModuleInput!
    
    var openMainCalled = false
    var setupInitialStateCalled = false
    var errorMessageShowed: String? = nil
    
    override func openModule(segueIdentifier: String) {
        if segueIdentifier == "main" {
            openMainCalled = true
        }
    }
    
    override func showError(message: String) {
        errorMessageShowed = message
    }
    
    override func setupInitialState() {
        setupInitialStateCalled = true
    }
}

//extension MockSigninViewController: SigninViewInput {
//    func setupInitialState() {
//        setupInitialStateCalled = true
//    }
//}
//
//extension MockSigninViewController: ModuleInputProvider {}

// MARK: - Signin Presenter Mock

class MockSigninPresenter {
    weak var view: SigninViewInput?
    let interactor: SigninInteractorInput
    let router: SigninRouterInput
    
    var viewIsReadyCalled = false
    var onSigninCalled = false
    var successCalled = false
    var failureCalled = false
    
    init(interactor: SigninInteractorInput, router: SigninRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension MockSigninPresenter: SigninModuleInput {}

extension MockSigninPresenter: SigninViewOutput {
    func viewIsReady() {
        viewIsReadyCalled = true
    }
    
    func onSignin(username: String?, password: String?) {
        onSigninCalled = true
    }
}

extension MockSigninPresenter: SigninInteractorOutput {
    func success() {
        successCalled = true
    }
    
    func failure(_ authError: AuthErrorType) {
        failureCalled = true
    }
}

// MARK: - Signin Router Mock

class MockSigninRouter: SigninRouterInput {
    var openMainCalled = false
    
    weak var segueHandler: SegueHandler?
    
    func openMain() {
        openMainCalled = true
    }
}

// MARK: - Signin Interactor Mock

class MockSigninInteractor: SigninInteractorInput {
    weak var output: SigninInteractorOutput?
    
    var signinCalled = false
    
    let service: AuthorizationServiceType
    
    init(service: AuthorizationServiceType) {
        self.service = service
    }
    
    func signin(withCredentials credentials: SigninCredentials) {
        signinCalled = true
    }
    
    var isTestingAuthorizedScenario = false
    
    func isAuthorized() -> Bool {
        return isTestingAuthorizedScenario
    }
}
