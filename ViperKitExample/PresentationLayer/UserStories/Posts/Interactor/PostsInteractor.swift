//
//  PostsInteractor.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 12/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit
import PromiseKit

class PostsInteractor: PostsInteractorInput {
    weak var output: PostsInteractorOutput?
    
    //MARK: - Services
    let authService: AuthorizationServiceType!
    let postService: PostServiceType!
    
    init(postService: PostServiceType, authService: AuthorizationServiceType) {
        self.postService = postService
        self.authService = authService
    }
    
    func loadData() {
        firstly {
            self.postService.getPosts(forUser: nil)
        }.then { posts in
            self.output?.postsLoaded(posts)
        }.catch { error in
            self.output?.encounteredError(error: error)
        }
    }
    
    func deletePost(_ post: Post) {
        firstly {
            self.postService.deletePost(post.id)
        }.then { _ in
            self.output?.postDeleted(post)
        }.catch { error in
            self.output?.encounteredError(error: error)
        }
    }
    
    func logout() {
        self.authService.logout()
    }
}
