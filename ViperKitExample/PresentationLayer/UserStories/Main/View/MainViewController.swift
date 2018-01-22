//
//  MainViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class MainViewController: BaseViewController {
    var output: MainViewOutput!
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

extension MainViewController: MainViewInput {
    
}

// MARK: - Module Input

extension MainViewController: ModuleInputProvider {}
