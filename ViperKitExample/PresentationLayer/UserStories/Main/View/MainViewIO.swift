//
//  MainViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol MainViewInput: class, ViewInput {
}

protocol MainViewOutput {
    func viewIsReady()
}