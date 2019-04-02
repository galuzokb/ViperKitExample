//
//  SplashTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/26/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample
import ViperKit

class SplashTests: XCTestCase {
    
    var assembliesFactory: MockSplashAssembliesFactory!
    var assembly: MockSplashModuleAssembly!
    
    var viewController: MockSplashViewController!
    var presenter: MockSplashPresenter!
    var interactor: MockSplashInteractor!
    var router: MockSplashRouter!
    var segueHandler: SegueHandler!
    
    override func setUp() {
        super.setUp()
        
        assembliesFactory = MockSplashAssembliesFactory()
        assembly = assembliesFactory.resolve()
        
        viewController =  try! assembly.container.resolve()
        
//        viewController = MockSplashViewController()
//
//        router = MockSplashRouter()
//        router.segueHandler = viewController
//
//        interactor = MockSplashInteractor()
//
//        presenter = MockSplashPresenter(interactor: interactor, router: router)
//        presenter.view = viewController
//
//        viewController.output = presenter
    }
    
    override func tearDown() {
        assembliesFactory = nil
        assembly = nil
        viewController = nil
        presenter = nil
        interactor = nil
        router = nil
        segueHandler = nil
        super.tearDown()
    }
    
    // MARK: - Presenter Tests
    
    func testViewAppearedOnAuthorizedState() {
        // given
        guard
            let p = viewController.output as? MockSplashPresenter,
            let r = p.router as? MockSplashRouter,
            let i = p.interactor as? MockSplashInteractor
        else {
            XCTFail()
            return
        }
        i.isTestingAuthorizedScenario = true
        // when
        if p.interactor.isAuthorized() {
            p.router.openMain()
        } else {
            p.router.openSignin()
        }
        // then
        let result = r.openMainCalled
        XCTAssert(result)
    }
    
    func testViewAppearedOnUnauthorizedState() {
        // given
        guard
            let p = viewController.output as? MockSplashPresenter,
            let r = p.router as? MockSplashRouter,
            let i = p.interactor as? MockSplashInteractor
        else {
            XCTFail()
            return
        }
        i.isTestingAuthorizedScenario = false
        // when
        if p.interactor.isAuthorized() {
            p.router.openMain()
        } else {
            p.router.openSignin()
        }
        // then
        let result = r.openSigninCalled
        XCTAssert(result)
    }

    // MARK: - Router Tests

    func testOpenMain() {
        // given
        guard
            let p = viewController.output as? MockSplashPresenter,
            let r = p.router as? MockSplashRouter,
            let sh = r.segueHandler as? MockSplashViewController
        else {
            XCTFail()
            return
        }
        let seguename = "main"
        // when
        sh.openModule(segueIdentifier: seguename)
        // then
        XCTAssert(viewController.openMainCalled)
    }

    func testOpenSignin() {
        // given
        guard
            let p = viewController.output as? MockSplashPresenter,
            let r = p.router as? MockSplashRouter,
            let sh = r.segueHandler as? MockSplashViewController
        else {
            XCTFail()
            return
        }
        let seguename = "signin"
        // when
        sh.openModule(segueIdentifier: seguename)
        // then
        XCTAssert(viewController.openSigninCalled)
    }

    // MARK: - View Tests

    func testViewDidAppear() {
        // given
        guard let p = viewController.output as? MockSplashPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.viewAppeared()
        // then
        XCTAssert(p.viewAppearedCalled)
    }

    func testViewDidLoad() {
        // given
        guard let p = viewController.output as? MockSplashPresenter else {
            XCTFail()
            return
        }
        // when
        viewController.output.viewIsReady()
        // then
        XCTAssert(p.viewIsReadyCalled)
    }
}
