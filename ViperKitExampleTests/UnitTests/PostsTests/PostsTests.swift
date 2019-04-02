//
//  PostsTests.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

// given

// when

// then


import Foundation
@testable import ViperKitExample
import ViperKit
import UIKit

class PostsTests: XCTestCase {
    var assembliesFactory: MockPostsAssembliesFactory!
    var assembly: MockPostsModuleAssembly!
    
    var viewController: MockPostsViewController!
    var displayManager: MockPostsDisplayManager!
    var postsCell: MockPostsTableViewCell!
    
    override func setUp() {
        super.setUp()
        
        assembliesFactory = MockPostsAssembliesFactory()
        assembly = assembliesFactory.resolve()
        viewController = try! assembly.container.resolve()
        
        
        let _ = viewController.view
        
        viewController.someTextLbl = UILabel(frame: .zero)
        viewController.tableView = UITableView()
        viewController.createPostBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
        
        displayManager = MockPostsDisplayManager(tableView: viewController.tableView)
        displayManager.delegate = viewController
        viewController.displayManager = displayManager
        postsCell = MockPostsTableViewCell(style: .default, reuseIdentifier: "postsCell")
        postsCell.delegate = displayManager
    }
    
    override func tearDown() {
        viewController = nil
        assembly = nil
        assembliesFactory = nil
        
        super.tearDown()
    }
}
