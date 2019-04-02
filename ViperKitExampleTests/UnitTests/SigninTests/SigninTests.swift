//
//  SigninTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/29/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample
import ViperKit

class SigninTests: XCTestCase {
    var assembliesFactory: MockSigninAssembliesFactory!
    var assembly: MockSigninModuleAssembly!
    
    var viewController: MockSigninViewController!
    
    override func setUp() {
        super.setUp()
        
        assembliesFactory = MockSigninAssembliesFactory()
        assembly = assembliesFactory.resolve()
        viewController =  try! assembly.container.resolve()
        let _ = viewController.view
    }
    
    override func tearDown() {
        viewController = nil
        assembly = nil
        assembliesFactory = nil
        
        super.tearDown()
    }
    
    // MARK: View Controller Tests
    
    func testViewDidLoad() {
        // given
        guard let presenter = viewController.output as? MockSigninPresenter else {
            XCTFail()
            return
        }
        presenter.viewIsReadyCalled = false
        // when
        viewController.output.viewIsReady()
        // then
        XCTAssert(presenter.viewIsReadyCalled)
    }
    
    func testOnSignin() {
        // given
        guard let presenter = viewController.output as? MockSigninPresenter else {
            XCTFail()
            return
        }
        presenter.onSigninCalled = false
        // when
        viewController.output.onSignin(username: nil, password: nil)
        // then
        XCTAssert(presenter.onSigninCalled)
    }
    
    // MARK: - Presenter Tests
    
    func testViewIsReady() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let view = presenter.view
        else {
            XCTFail()
            return
        }
        viewController.setupInitialStateCalled = false
        // when
        view.setupInitialState()
        // then
        XCTAssert(viewController.setupInitialStateCalled)
    }
    //TODO: finish when base controllers mocks created
//    func testOnSignInWithEmptyUsername() {
//
//    }
//
//    func testOnSigninWithEmptyPassword() {
//
//    }
//
//    func testOnSigninWithEmptyCredentials() {
//
//    }
    
    func testSuccess() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let router = presenter.router as? MockSigninRouter
        else {
            XCTFail()
            return
        }
        router.openMainCalled = false
        // when
        presenter.router.openMain()
        // then
        XCTAssert(router.openMainCalled)
    }
    
    func testFailureWithWrongUsername() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let view = presenter.view as? MockSigninViewController
        else {
            XCTFail()
            return
        }
        let authError: AuthErrorType = .wrongUsername
        // when
        switch authError {
        case .wrongUsername:
            presenter.view?.showError(message: "Wrong username!")
        case .wrongPassword:
            presenter.view?.showError(message: "Wrong password!")
        case .wrongCredentials:
            presenter.view?.showError(message: "Wrong credentials!")
        }
        // then
        XCTAssert(viewController.errorMessageShowed != nil, "Error message shouldn't be nil")
        XCTAssert(viewController.errorMessageShowed! == "Wrong username!", "error messae should be \"Wrong username!\"")
//        XCTAssert(viewController.showErrorCalled)
    }

    func testFailureWithWrongPassword() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let view = presenter.view as? MockSigninViewController
        else {
            XCTFail()
            return
        }
        let authError: AuthErrorType = .wrongPassword
        // when
        switch authError {
        case .wrongUsername:
            view.showError(message: "Wrong username!")
        case .wrongPassword:
            view.showError(message: "Wrong password!")
        case .wrongCredentials:
            view.showError(message: "Wrong credentials!")
        }
        // then
        XCTAssert(viewController.errorMessageShowed != nil, "Error message shouldn't be nil")
        XCTAssert(viewController.errorMessageShowed! == "Wrong password!", "error messae should be \"Wrong password!\"")
//        XCTAssert(viewController.showErrorCalled)
    }

    func testFailureWithWrongCredentials() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let view = presenter.view as? MockSigninViewController
        else {
            XCTFail()
            return
        }
        let authError: AuthErrorType = .wrongCredentials
        // when
        switch authError {
        case .wrongUsername:
            view.showError(message: "Wrong username!")
        case .wrongPassword:
            view.showError(message: "Wrong password!")
        case .wrongCredentials:
            view.showError(message: "Wrong credentials!")
        }
        // then
        XCTAssert(viewController.errorMessageShowed != nil, "Error message shouldn't be nil")
        XCTAssert(viewController.errorMessageShowed! == "Wrong credentials!", "error messae should be \"Wrong credentials!\"")
//        XCTAssert(viewController.showErrorCalled)
    }
    
    // MARK: - Router Tests
    
    func testOpenMain() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let router = presenter.router as? MockSigninRouter,
            let segueHandler = router.segueHandler as? MockSigninViewController
        else {
            XCTFail()
            return
        }
        segueHandler.openMainCalled = false
        // when
        router.segueHandler?.openModule(segueIdentifier: "main")
        // then
        XCTAssert(segueHandler.openMainCalled)
    }
    
    // MARK: - Interactor Tests
    
    func testSigninWithValidCredentials() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let interactor = presenter.interactor as? MockSigninInteractor,
            let interactorOutput = interactor.output as? MockSigninPresenter
        else {
            XCTFail()
            return
        }
        let service = interactor.service
        presenter.failureCalled = false
        presenter.successCalled = false
        let validCredentials = SigninCredentials(username: "correctUsername", password: "correctPassword")
        // when
        if let authError = service.signin(validCredentials) {
            interactor.output?.failure(authError)
        } else {
            interactor.output?.success()
        }
        // then
        XCTAssert(!interactorOutput.failureCalled)
        XCTAssert(interactorOutput.successCalled)
    }
    
    func testSigninWithWrongUsername() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let interactor = presenter.interactor as? MockSigninInteractor,
            let interactorOutput = interactor.output as? MockSigninPresenter
        else {
            XCTFail()
            return
        }
        let service = interactor.service
        presenter.failureCalled = false
        presenter.successCalled = false
        let validCredentials = SigninCredentials(username: "wrongUsername", password: "correctPassword")
        // when
        if let authError = service.signin(validCredentials) {
            interactor.output?.failure(authError)
        } else {
            interactor.output?.success()
        }
        // then
        XCTAssert(interactorOutput.failureCalled)
        XCTAssert(!interactorOutput.successCalled)
    }
    
    func testSigninWithWrongPassword() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let interactor = presenter.interactor as? MockSigninInteractor,
            let interactorOutput = interactor.output as? MockSigninPresenter
        else {
            XCTFail()
            return
        }
        let service = interactor.service
        presenter.failureCalled = false
        presenter.successCalled = false
        let validCredentials = SigninCredentials(username: "correctUsername", password: "wrongPassword")
        // when
        if let authError = service.signin(validCredentials) {
            interactor.output?.failure(authError)
        } else {
            interactor.output?.success()
        }
        // then
        XCTAssert(interactorOutput.failureCalled)
        XCTAssert(!interactorOutput.successCalled)
    }
    
    func testSigninWithWrongCredentials() {
        // given
        guard
            let presenter = viewController.output as? MockSigninPresenter,
            let interactor = presenter.interactor as? MockSigninInteractor,
            let interactorOutput = interactor.output as? MockSigninPresenter
        else {
            XCTFail()
            return
        }
        let service = interactor.service
        presenter.failureCalled = false
        presenter.successCalled = false
        let validCredentials = SigninCredentials(username: "wrongUsername", password: "wrongPassword")
        // when
        if let authError = service.signin(validCredentials) {
            interactor.output?.failure(authError)
        } else {
            interactor.output?.success()
        }
        // then
        XCTAssert(interactorOutput.failureCalled)
        XCTAssert(!interactorOutput.successCalled)
    }
}
