//
//  PostRouterTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostRouterTests: PostBaseTests {
    
    func testClose() {
        // given
        guard
            let presenter = viewController.output as? MockPostPresenter,
            let router = presenter.router as? MockPostRouter
        else {
            XCTFail("presenter and router shouldn't be nil")
            return
        }
        // when
        router.segueHandler?.closeModule()
        // then
        XCTAssertTrue(viewController.closeModuleCalled, "cloes module should be called")
    }
}
