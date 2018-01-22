//
//  PostPostInteractorIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

//MARK: - Interacor Input

protocol PostInteractorInput {
    func changePost(_ id: Int, title: String?, body: String?)
}

//MARK: - Interactor Output

protocol PostInteractorOutput: class {
    func postChanged(withTitle title: String?, withBody body: String?)
    func encounteredError(error: Error)
}
