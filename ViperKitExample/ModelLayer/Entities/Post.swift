//
//  Post.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ObjectMapper

struct Post {
    var id: Int
    
    var userID: Int?
    var title: String?
    var body: String?
}

extension Post: ImmutableMappable {
    init(map: Map) throws {
        id = try map.value("id")
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        
        userID  <- map["userId"]
        title   <- map["title"]
        body    <- map["body"]
    }
}

extension Post: Equatable {
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id && lhs.userID == rhs.userID && lhs.title == rhs.title && lhs.body == rhs.body
    }
}
