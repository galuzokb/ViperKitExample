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

class MainViewController: BaseTabBarController, ViewInput {
    var output: MainViewOutput!
    var moduleInput: ModuleInput!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        output.viewIsReady()
    }
    
    // MARK: IBActions
}

// MARK: - View Input

extension MainViewController: MainViewInput {
    func startIndication() {}
    
    func stopIndication() {}
    
    func showSuccess() {}
    
    func showMessage(message: String) {}
    
    func showError() {}
    
    func showError(message: String) {}
    
    func selectedIndex(_ index: Int) {
        selectedIndex = index
    }
    
    func hideSearch() {
        guard let searchVC = (viewControllers?[1] as? UINavigationController)?.viewControllers.first as? SearchViewController else { return }
        searchVC.hideSearch()
    }
}

// MARK: - Module Input

extension MainViewController: ModuleInputProvider {}

// MARK: - UITabBarControllerDelegate

extension MainViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let controllerIndex = self.viewControllers?.index(of: viewController){
            output.shouldSelectIndex(controllerIndex)
        }
        
        return false
    }
}
