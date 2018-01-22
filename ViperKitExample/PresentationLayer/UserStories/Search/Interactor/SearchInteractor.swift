//
//  SearchInteractor.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit
import PromiseKit

class SearchInteractor: SearchInteractorInput {
    weak var output: SearchInteractorOutput?
    
    //MARK: - Services
    let postService: PostServiceType!
    
    init(postService: PostServiceType) {
        self.postService = postService
    }
    
    func getPosts(byUserID userID: Int) {
        firstly {
            self.postService.getPosts(forUser: userID)
        }.then { posts in
            self.output?.postsLoaded(posts)
        }.catch { error in
            self.output?.encounteredError(error: error)
        }
    }
}
