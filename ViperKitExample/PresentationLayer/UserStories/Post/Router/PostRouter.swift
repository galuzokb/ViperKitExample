//
//  PostPostRouter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

class PostRouter: PostRouterInput {
    weak var segueHandler: SegueHandler?
    
    func close() {
        segueHandler?.closeModule()
    }
}
