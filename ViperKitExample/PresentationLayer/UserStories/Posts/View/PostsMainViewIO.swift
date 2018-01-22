//
//  PostsViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 12/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol PostsViewInput: class, ViewInput {
    func setupInitialState()
    func setupDisplayManager()
    func setupCreatePostBtn(_ state: Bool)
    
    func setItems(_ items: [Post])
    func setText(_ text: String?)
    
    func setChangedPost(_ post: Post)
    
    func stopRefreshing()
}

protocol PostsViewOutput {
    func viewIsReady()
    func viewAppearing()
    
    func editSomeText(_ text: String?)
    func postSelected(post: Post)
    func refreshPosts()
    func deletePost(_ post: Post)
    func logout()
}
