//
//  TextEditBaseTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class TextEditBaseTests: XCTestCase {
    
    var assembliesFactory: MockTextEditAssembliesFactory!
    var moduleAssembly: MockTextEditModuleAssembly!
    var viewController: MockTextEditViewController!
    
    override func setUp() {
        super.setUp()
        
        assembliesFactory = MockTextEditAssembliesFactory()
        moduleAssembly = assembliesFactory.resolve()
        viewController = try! moduleAssembly.container.resolve()
    }
    
    override func tearDown() {
        viewController = nil
        moduleAssembly = nil
        assembliesFactory = nil
        
        super.tearDown()
    }
}
