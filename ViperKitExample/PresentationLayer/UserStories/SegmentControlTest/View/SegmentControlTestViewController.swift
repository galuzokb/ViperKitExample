//
//  SegmentControlTestViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class SegmentControlTestViewController: BaseViewController {
    var output: SegmentControlTestViewOutput!
    var moduleInput: ModuleInput!
    
    
    let segues = ["first", "second"]
    // MARK: Outlets
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: IBActions
    @IBAction func switchControllers(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.5) {
            if sender.selectedSegmentIndex == 0 {
                self.firstContainerView.alpha = 1
                self.secondContainerView.alpha = 0
            } else {
                self.firstContainerView.alpha = 0
                self.secondContainerView.alpha = 1
            }
        }
    }
}

// MARK: - View Input

extension SegmentControlTestViewController: SegmentControlTestViewInput {
    func setupInitialState() {
        firstContainerView.alpha = 1
        secondContainerView.alpha = 0
    }
}

// MARK: - Module Input

extension SegmentControlTestViewController: ModuleInputProvider {}
