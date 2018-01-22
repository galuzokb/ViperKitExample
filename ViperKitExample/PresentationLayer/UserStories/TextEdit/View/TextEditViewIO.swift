//
//  TextEditTextEditViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol TextEditViewInput: class, ViewInput {
    func setText(_ text: String?)
}

protocol TextEditViewOutput {
    func viewIsReady()
    func cancel()
    func done(_ text: String?)
}
