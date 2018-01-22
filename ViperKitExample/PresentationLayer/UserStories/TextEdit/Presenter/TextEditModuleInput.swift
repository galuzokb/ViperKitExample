//
//  TextEditTextEditModuleInput.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol TextEditModuleInput: ModuleInput {
    func setModuleOutput(_ output: TextEditModuleOutput)
    func setText(_ text: String?)
}

protocol TextEditModuleOutput: class {
    func textChanged(_ text: String?)
}
