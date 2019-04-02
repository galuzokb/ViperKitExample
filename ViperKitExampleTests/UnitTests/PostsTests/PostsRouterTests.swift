//
//  PostsRouterTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/3/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostsRouterTests: PostsTests {
    
    var teAssembliesFavtory: MockTextEditAssembliesFactory!
    var teAssembly: MockTextEditModuleAssembly!
    var textEditViewController: MockTextEditViewController!
    
    var postAssembliesFactory: MockPostAssembliesFactory!
    var postModuleAssembly: MockPostModuleAssembly!
    var postViewController: MockPostViewController!
    
    override func setUp() {
        super.setUp()
        
        teAssembliesFavtory = MockTextEditAssembliesFactory()
        teAssembly = teAssembliesFavtory.resolve()
        textEditViewController = try! teAssembly.container.resolve()
        
        postAssembliesFactory = MockPostAssembliesFactory()
        postModuleAssembly = postAssembliesFactory.resolve()
        postViewController = try! postModuleAssembly.container.resolve()
    }
    
    override func tearDown() {
        teAssembliesFavtory = nil
        teAssembly = nil
        textEditViewController = nil
        
        postViewController = nil
        postModuleAssembly = nil
        postAssembliesFactory = nil
        
        super.tearDown()
    }
    
    func testOpenLogin() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let router = presenter.router as? MockPostsRouter
        else {
            XCTFail("presenter or rouer shouldn't be nil")
            return
        }
        // when
        router.segueHandler?.closeModule()
        // then
        XCTAssertTrue(viewController.closeModuleCalled, "closeModule() should be called")
    }
    
    func testOpenEditText() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let router = presenter.router as? MockPostsRouter,
            let input = textEditViewController.moduleInput,
            let moduleInput = input as? MockTextEditPresenter,
            let textEditPresenter = textEditViewController.output as? MockTextEditPresenter
        else {
            XCTFail("presenter or rouer shouldn't be nil")
            return
        }
        let text = "text"
        // when
        router.segueHandler?.openModule(segueIdentifier: "textEdit", configurationBlock: { _ in })
        // then
        XCTAssertTrue(viewController.openModuleWithBlockCalled, "openModule(..,..) should be called")
        
        moduleInput.setModuleOutput(presenter)
        moduleInput.setText(text)
        
        XCTAssertTrue(textEditPresenter.setTextCalled, "setText(..) should be called")
        XCTAssertTrue(textEditPresenter.setModuleOutputCalled, "setModuleOutput(..) should be called")
    }
    
    func testOpenPost() {
        // given
        guard
            let presenter = viewController.output as? MockPostsPresenter,
            let router = presenter.router as? MockPostsRouter,
            let input = postViewController.moduleInput,
            let moduleInput = input as? MockPostPresenter,
            let postPresenter = postViewController.output as? MockPostPresenter
        else {
            XCTFail("presenter or rouer shouldn't be nil")
            return
        }
        let post = Post(id: 1, userID: 1, title: "title", body: "body")
        // when
        router.segueHandler?.openModule(segueIdentifier: "post", configurationBlock: { _ in })
        // then
        XCTAssertTrue(viewController.openModuleWithBlockCalled, "openModule(..,..) should be called")
        
        moduleInput.setOutput(presenter)
        moduleInput.setPost(post)
        
        XCTAssertTrue(postPresenter.setOutputCalled, "setOutput(..) should be called")
        XCTAssertTrue(postPresenter.setPostCalled, "setPost(..) should be called")
    }
}
