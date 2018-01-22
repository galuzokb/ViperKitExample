//
//  TestData.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ObjectMapper

struct TestData {
    var id: Int
    var name: String
    var description: String
    var date: Date
}

extension TestData: ImmutableMappable {
    init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        description = try map.value("description")
        date = try map.value("data", using: DateTransformStringJson())
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        description <- map["description"]
        date        <- (map["date"], DateTransformStringJson())
    }
}
