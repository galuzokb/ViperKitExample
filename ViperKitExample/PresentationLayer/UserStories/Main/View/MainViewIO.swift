//
//  MainViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol MainViewInput: class, ViewInput {
    func selectedIndex(_ index: Int)
    func hideSearch()
}

protocol MainViewOutput {
    func viewIsReady()
    func close()
    func shouldSelectIndex(_ index: Int)
}
