//
//  BaseTableViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/19/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import UIKit
import ViperKit
import PKHUD

extension BaseTableViewController: ViewInput {
    
    open override func viewDidLoad() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
    }
    
    public func startIndication() {
        HUD.show(.progress)
    }
    
    public func stopIndication() {
        HUD.hide()
    }
    
    public func showSuccess() {
        
    }
    
    public func showMessage(message: String) {
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { _ in })
        present(alertController, animated: true)
    }
    
    public func showError() {
        
    }
    
    public func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { _ in })
        present(alertController, animated: true)
    }
}

extension BaseTableViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
