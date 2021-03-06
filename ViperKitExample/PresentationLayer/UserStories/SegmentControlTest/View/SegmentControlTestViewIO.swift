//
//  SegmentControlTestViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol SegmentControlTestViewInput: class, ViewInput {
    func setupInitialState()
}

protocol SegmentControlTestViewOutput {
    func viewIsReady()
}
