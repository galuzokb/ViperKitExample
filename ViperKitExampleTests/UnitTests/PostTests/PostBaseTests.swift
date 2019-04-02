//
//  PostBaseTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/4/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class PostBaseTests: XCTestCase {
    
    var assembliesFactory: MockPostAssembliesFactory!
    var moduleAssembly: MockPostModuleAssembly!
    var viewController: MockPostViewController!
    
    override func setUp() {
        super.setUp()
        
        assembliesFactory = MockPostAssembliesFactory()
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
