//
//  UIStorage.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 6/25/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
@testable import ViperKitExample

class UIStorage {
    static let shared = UIStorage()
    
    private var post: Post

    init() {
        post = Post(id: -1, userID: -1, title: nil, body: nil)
    }
    
    var currentPost: Post {
        get {
            return post
        }
        set {
            post = newValue
        }
    }
}
