//
//  PostsInteractorIO.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 12/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit

//MARK: - Interacor Input

protocol PostsInteractorInput {
    func loadData()
    func deletePost(_ post: Post)
    func logout()
}

//MARK: - Interactor Output

protocol PostsInteractorOutput: class {
    func postsLoaded(_ posts: [Post])
    func postDeleted(_ post: Post)
    func encounteredError(error: Error)
}
