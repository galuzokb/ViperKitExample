//
//  TextEditViewControllerTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class TextEditViewControllerTests: TextEditBaseTests {
    func testViewDidLoad() {
        // given
        guard let presenter = viewController.output as? MockTextEditPresenter else {
            XCTFail("View controller's  output shouldn't be nil")
            return
        }
        // when
        viewController.output.viewIsReady()
        // then
        XCTAssertTrue(presenter.viewIsReadyCalled, "viewIsReady() should be called")
    }
    
    func testCancel() {
        // given
        guard let presenter = viewController.output as? MockTextEditPresenter else {
            XCTFail("View controller's  output shouldn't be nil")
            return
        }
        // when
        viewController.output.cancel()
        // then
        XCTAssertTrue(presenter.cancelCalled, "cancel() should be called")
    }
    
    func testDone() {
        // given
        guard let presenter = viewController.output as? MockTextEditPresenter else {
            XCTFail("View controller's  output shouldn't be nil")
            return
        }
        let text = "text"
        // when
        viewController.output.done(text)
        // then
        XCTAssertTrue(presenter.doneCalled, "done(..) should be called")
    }
    
    func testSetText() {
        // given
        viewController.textView = UITextView(frame: .zero)
        let text = "text"
        // when
        viewController.textView.text = text
        // then
        XCTAssertEqual(viewController.textView.text, text, "text should be set")
    }
}
