//
//  PostPostViewIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

protocol PostViewInput: class, ViewInput {
    func setupInitialState()
    func setupPost(_ post: Post)
    func setDoneBtnState(_ isEnabled: Bool)
}

protocol PostViewOutput {
    func viewIsReady()
    
    func done(title: String?, body: String?)
    func back()
    
    func titleDidChange(_ title: String)
    func bodyDidChange(_ body: String)
}
