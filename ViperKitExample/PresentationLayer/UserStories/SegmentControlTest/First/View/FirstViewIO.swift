//
//  FirstViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 18/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol FirstViewInput: class, ViewInput {
}

protocol FirstViewOutput {
    func viewIsReady()
}