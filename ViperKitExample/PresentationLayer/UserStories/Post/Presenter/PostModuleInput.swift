//
//  PostPostModuleInput.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol PostModuleInput: ModuleInput {
    func setPost(_ post: Post?)
    func setOutput(_ output: PostModuleOutput)
}

protocol PostModuleOutput: class {
    func postChanged(_ post: Post)
}
