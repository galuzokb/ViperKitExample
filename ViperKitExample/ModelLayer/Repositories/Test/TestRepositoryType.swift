//
//  TestRepositoryType.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import PromiseKit

protocol TestRepositoryType {
    func getTestData() -> Promise<[TestData]>
}
