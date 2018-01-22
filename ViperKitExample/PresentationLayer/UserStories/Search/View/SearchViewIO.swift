//
//  SearchViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol SearchViewInput: class, ViewInput {
    func setupInitialState()
    func setPosts(_ posts: [Post])
    func setChangedPost(_ post: Post)
}

protocol SearchViewOutput {
    func viewIsReady()
    func postSelected(_ post: Post)
    func search(_ keyword: String?)
    func cancelSearch()
}
