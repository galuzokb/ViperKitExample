//
//  Comment.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/19/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ObjectMapper

struct Comment {
    var id: Int
    var postID: Int
    
    var name: String?
    var email: String?
    var body: String?
}

extension Comment: ImmutableMappable {
    
    init(map: Map) throws {
        id = try map.value("id")
        postID = try map.value("postId")
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        postID  <- map["postId"]
        
        name    <- map["name"]
        body    <- map["body"]
    }
}
