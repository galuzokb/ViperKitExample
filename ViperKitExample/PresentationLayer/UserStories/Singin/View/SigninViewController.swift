//
//  SigninViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class SigninViewController: BaseViewController {
    var output: SigninViewOutput!
    var moduleInput: ModuleInput!
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    @IBAction func signin(_ sender: UIButton) {
        output.onSignin(username: usernameTF.text, password: passwordTF.text)
    }
}

extension SigninViewController: SigninViewInput {
    
    func setupInitialState() {
        print("asdasd")
    }
}

extension SigninViewController: ModuleInputProvider {}
