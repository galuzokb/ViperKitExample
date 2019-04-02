//
//  CreatePostCreatePostViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class CreatePostViewController: ViperKitExampleBaseViewController {
    var output: CreatePostViewOutput!
    var moduleInput: ModuleInput!
    
    // MARK: Outlets
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: IBActions
}

// MARK: - View Input

extension CreatePostViewController: CreatePostViewInput {
    
}

// MARK: - Module Input

extension CreatePostViewController: ModuleInputProvider {}
