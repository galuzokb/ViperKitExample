//
//  SearchRouterInput.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol SearchRouterInput {
    func openPost(withOutput output: PostModuleOutput, post: Post)
}
