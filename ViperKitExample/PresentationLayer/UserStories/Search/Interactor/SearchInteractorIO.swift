//
//  SearchInteractorIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

//MARK: - Interacor Input

protocol SearchInteractorInput {
    func getPosts(byUserID userID: Int)
}

//MARK: - Interactor Output

protocol SearchInteractorOutput: class {
    func postsLoaded(_ posts: [Post])
    func encounteredError(error: Error)
}
