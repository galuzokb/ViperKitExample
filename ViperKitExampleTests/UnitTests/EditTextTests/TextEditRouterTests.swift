//
//  TextEditRouterTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class TextEditRouterTests: TextEditBaseTests {
    
    func testClose() {
        // given
        guard
            let presenter = viewController.output as? MockTextEditPresenter,
            let router = presenter.router as? MockTextEditRouter
        else {
            XCTFail("presenter and router shouldn't be nil")
            return
        }
        // when
        router.segueHandler?.closeModule()
        // then
        XCTAssertTrue(viewController.closeModuleCalled, "closeModule() should be called")
    }
}
