//
//  TextEditPresenterTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class TextEditPresenterTests: TextEditBaseTests {
    
    var postsAssembliesFactory: MockPostsAssembliesFactory!
    var postsModuleAssembly: MockPostsModuleAssembly!
    var postsViewController: MockPostsViewController!
    
    override func setUp() {
        super.setUp()
        
        postsAssembliesFactory = MockPostsAssembliesFactory()
        postsModuleAssembly = postsAssembliesFactory.resolve()
        postsViewController = try! postsModuleAssembly.container.resolve()
    }
    
    override func tearDown() {
        postsAssembliesFactory = nil
        postsModuleAssembly = nil
        postsViewController = nil
        
        super.tearDown()
    }
    
    func testSetModuleOutput() {
        // given
        guard
            let presenter = viewController.output as? MockTextEditPresenter,
            let postsPresenter = postsViewController.output as? MockPostsPresenter
        else {
            XCTFail("postsPresenter and presenter shouldn't be nil")
            return
        }
        // when
        presenter.output = postsPresenter
        // then
        XCTAssertTrue(presenter.outputDidSet, "output should be set")
    }
    
    func testSetText() {
        // given
        guard let presenter = viewController.output as? MockTextEditPresenter else {
            XCTFail("postsPresenter and presenter shouldn't be nil")
            return
        }
        let text = "text"
        // when
        presenter.text = text
        // then
        XCTAssertTrue(presenter.textDidSet, "texts should be set")
        XCTAssertEqual(text, presenter.text)
    }
    
    func testViewIsReady() {
        // given
        guard let presenter = viewController.output as? MockTextEditPresenter else {
            XCTFail("presenter shouldn't be nil")
            return
        }
        let text = "text"
        // when
        presenter.view?.setText(text)
        // then
        XCTAssertTrue(viewController.setTextCalled, "setText(..) should be called")
    }
    
    func testCancel() {
        // given
        guard
            let presenter = viewController.output as? MockTextEditPresenter,
            let router = presenter.router as? MockTextEditRouter
        else {
            XCTFail("router and presenter shouldn't be nil")
            return
        }
        // when
        presenter.router.close()
        // then
        XCTAssertTrue(router.closeCalled, "close() should be called")
    }
    
    func testDone() {
        // given
        guard
            let presenter = viewController.output as? MockTextEditPresenter,
            let postsPresenter = postsViewController.output as? MockPostsPresenter,
            let router = presenter.router as? MockTextEditRouter
        else {
            XCTFail("postsPresenter and presenter shouldn't be nil")
            return
        }
        presenter.output = postsPresenter
        let text = "text"
        // when
        presenter.output?.textChanged(text)
        presenter.router.close()
        // then
        XCTAssertTrue(postsPresenter.textChangedCalled, "textChanged(..) should be called")
        XCTAssertTrue(router.closeCalled, "close() should be called")
    }
}
