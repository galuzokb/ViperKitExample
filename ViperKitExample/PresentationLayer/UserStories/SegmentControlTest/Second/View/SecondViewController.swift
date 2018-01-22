//
//  SecondViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 18/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class SecondViewController: BaseViewController {
    var output: SecondViewOutput!
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

extension SecondViewController: SecondViewInput {
    
}

// MARK: - Module Input

extension SecondViewController: ModuleInputProvider {}
