//
//  BaseViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import UIKit
import ViperKit
import PKHUD

class ViperKitExampleBaseViewController: BaseViewController, ViewInput {
    open override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    public func startIndication() {
        HUD.show(.progress)
        PKHUD.sharedHUD.contentView = MyHUD()
    }
    
    public func stopIndication() {
        HUD.hide()
    }
    
    public func showSuccess() {
        
    }
    
    public func showMessage(message: String) {
        showAlert("Message", message: message)
    }
    
    public func showError() {
        
    }
    
    public func showError(message: String) {
        showAlert("Error", message: message)
    }
    
    private func showAlert(_ title: String, message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            okAction.accessibilityLabel = "OK"
            alertController.addAction(okAction)
            self?.present(alertController, animated: true)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

