//
//  TestRepository.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import PromiseKit

class TestRepository: TestRepositoryType {
    
    let mapping: MappingType
    let network: NetworkType
    
    let baseURL = Constants.URLs.baseURL
    
    init(mapping: MappingType, network: NetworkType) {
        self.mapping = mapping
        self.network = network
    }
    
    func getTestData() -> Promise<[TestData]> {
        return firstly {
            self.network.request(method: .GET, url: baseURL + "ext/invest_projects/android_examples/stores.json")
        }.then { data in
            self.mapping.map(data: data)
        }
    }
}
