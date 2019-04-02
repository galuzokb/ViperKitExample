//
//  TextEditOutletTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class TextEditOtletTests: XCTestCase {
    
    var textEditViewController: TextEditViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "TextEdit", bundle: nil)
        textEditViewController = storyboard.instantiateViewController(withIdentifier: "TextEditViewController") as! TextEditViewController
        let _ = textEditViewController.view
    }
    
    override func tearDown() {
        textEditViewController = nil
        
        super.tearDown()
    }
    
    func testViewOutletSetup() {
        XCTAssertNotNil(textEditViewController.textView, "shouldn't be nil")
    }
    
    func testSetText() {
        // given
        let text = "text"
        let textView = textEditViewController.textView
        // when
        textEditViewController.textView.text = text
        // then
        XCTAssertEqual(textView?.text, text)
    }
}
