//
//  SearchRouter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

class SearchRouter: SearchRouterInput {    
    weak var segueHandler: SegueHandler?
    
    func openPost(withOutput output: PostModuleOutput, post: Post) {
        segueHandler?.openModule(segueIdentifier: "post", configurationBlock: { input in
            guard let moduleInput = input as? PostModuleInput else {
                fatalError("Wrong module input")
            }
            moduleInput.setPost(post)
            moduleInput.setOutput(output)
        })
    }
}
