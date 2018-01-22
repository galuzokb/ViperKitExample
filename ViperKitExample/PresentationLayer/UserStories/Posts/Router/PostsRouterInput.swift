//
//  PostsRouterInput.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 12/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol PostsRouterInput {
    func openEditText(withOutput output: TextEditModuleOutput, text: String?)
    func openLogin()
    func openPost(withOutput output: PostModuleOutput, post: Post)
}
