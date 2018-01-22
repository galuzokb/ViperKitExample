//
//  PostsPostsRouter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 12/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

class PostsRouter: PostsRouterInput {
    weak var segueHandler: SegueHandler?
    
    func openLogin() {
        segueHandler?.closeModule()
    }
    
    func openEditText(withOutput output: TextEditModuleOutput, text: String?) {
        segueHandler?.openModule(segueIdentifier: "textEdit", configurationBlock: { input in
            guard let moduleInput = input as? TextEditModuleInput else {
                fatalError("Wrong module input")
            }
            moduleInput.setModuleOutput(output)
            moduleInput.setText(text)
        })
    }
    
    func openPost(withOutput output: PostModuleOutput, post: Post) {
        segueHandler?.openModule(segueIdentifier: "post", configurationBlock: { input in
            guard let moduleInput = input as? PostModuleInput else {
                fatalError("Wrong module input")
            }
            moduleInput.setOutput(output)
            moduleInput.setPost(post)
        })
    }
}
