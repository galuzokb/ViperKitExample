//
//  SplashMocks.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/26/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

@testable import ViperKitExample
import ViperKit
import Dip
import UIKit
import Dip_UI

// MARK: - Splash View Controller
class MockSplashViewController: SplashViewController {
    var openMainCalled = false
    var openSigninCalled = false
    var closeModuleCalled = false
    
    override func openModule(segueIdentifier: String) {
        if segueIdentifier == "main" {
            openMainCalled = true
        } else if segueIdentifier == "signin" {
            openSigninCalled = true
        }
    }
    
    override func openModule(segueIdentifier: String, configurationBlock: @escaping ConfigurationBlock) {
        
    }
    
    override func closeModule() {
        closeModuleCalled = true
    }
}

// MARK: - Splash Interactor

class MockSplashInteractor: SplashInteractorInput {
    weak var output: SplashInteractorOutput?
    
    var isTestingAuthorizedScenario = false
    
    func isAuthorized() -> Bool {
        return isTestingAuthorizedScenario
    }
}

// MARK: - Splash Router

class MockSplashRouter: SplashRouterInput {
    var openMainCalled = false
    var openSigninCalled = false
    
    weak var segueHandler: SegueHandler?
    
    func openMain() {
        openMainCalled = true
    }
    
    func openSignin() {
        openSigninCalled = true
    }
}

// MARK: - Splash Presenter

class MockSplashPresenter {
    weak var view: SplashViewInput?
    let interactor: SplashInteractorInput
    let router: SplashRouterInput
    
    var viewIsReadyCalled = false
    var viewAppearedCalled = false
    
    init(interactor: SplashInteractorInput, router: SplashRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension MockSplashPresenter: SplashModuleInput {}

extension MockSplashPresenter: SplashViewOutput {
    func viewIsReady() {
        viewIsReadyCalled = true
    }
    
    func viewAppeared() {
        viewAppearedCalled = true
    }
}

extension MockSplashPresenter: SplashInteractorOutput {}

// MARK: - Assembly

class MockSplashAssembliesFactory: AssembliesFactory {
    override func registerPresentationLayer(root: RootViperAssembly) {
        container.register(.eagerSingleton) { MockSplashModuleAssembly(withCollaborator: $0) }
    }
}

class MockSplashModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { MockSplashViewController() }
            .implements(SplashViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as SplashModuleInput
        }
        
        container.register { MockSplashPresenter(interactor: $0, router: $1) }
            .implements(SplashModuleInput.self, SplashViewOutput.self, SplashInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
        }
        
        container.register { MockSplashRouter() }
            .implements(SplashRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
        }
        
        container.register { MockSplashInteractor() }
            .implements(SplashInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
        }
    }
}
