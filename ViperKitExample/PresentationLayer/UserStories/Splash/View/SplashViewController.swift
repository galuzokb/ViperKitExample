//
//  SplashViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/10/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class SplashViewController: BaseViewController {
    var output: SplashViewOutput!
    var moduleInput: ModuleInput!
    
    // MARK: Outlets
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewAppeared()
    }
    
    // MARK: IBActions
}

// MARK: - View Input

extension SplashViewController: SplashViewInput {
    
}

// MARK: - Module Input

extension SplashViewController: ModuleInputProvider {}
