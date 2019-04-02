//
//  MockBaseViewController.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample
import ViperKit

class MockBaseViewController: BaseViewController, ViewInput {
    var showErrorCalled = false
    var startIndicationCalled = false
    var stopIndicationCalled = false
    var showSuccessCalled = false
    var errorMessageShowed: String? = nil
    var messageShowed: String? = nil
    
    var openModuleCalled = false
    var openModuleWithBlockCalled = false
    var closeModuleCalled = false
    
    override func openModule(segueIdentifier: String) {
        openModuleCalled = true
    }
    
    override func openModule(segueIdentifier: String, configurationBlock: @escaping ConfigurationBlock) {
        openModuleWithBlockCalled = true
    }
    
    override func closeModule() {
        closeModuleCalled = true
    }
    
    func startIndication() {
        startIndicationCalled = true
    }
    
    func stopIndication() {
        stopIndicationCalled = true
    }
    
    func showSuccess() {
        showSuccessCalled = true
    }
    
    func showMessage(message: String) {
        messageShowed = message
    }
    
    func showError() {
        showErrorCalled = true
    }
    
    func showError(message: String) {
        errorMessageShowed = message
    }
}
