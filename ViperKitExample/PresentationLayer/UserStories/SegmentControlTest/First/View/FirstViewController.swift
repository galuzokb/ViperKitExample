//
//  FirstViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 18/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class FirstViewController: ViperKitExampleBaseViewController {
    var output: FirstViewOutput!
    var moduleInput: ModuleInput!
    
    // MARK: Outlets
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        startIndication()
    }
    // MARK: IBActions
}

// MARK: - View Input

extension FirstViewController: FirstViewInput {
    
}

// MARK: - Module Input

extension FirstViewController: ModuleInputProvider {}
