//
//  TestService.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import PromiseKit

class TestService: TestServiceType {
    
    let repository: TestRepositoryType
    
    init(repository: TestRepositoryType) {
        self.repository = repository
    }
    
    func getTestData() -> Promise<[TestData]> {
        return firstly {
            self.repository.getTestData()
        }
    }
}
