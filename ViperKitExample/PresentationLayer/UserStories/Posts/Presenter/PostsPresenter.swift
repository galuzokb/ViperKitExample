//
//  PostsPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 12/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class PostsPresenter {
    weak var view: PostsViewInput?
    let interactor: PostsInteractorInput
    let router: PostsRouterInput
    
    var isRefreshing = false
    
    var posts = [Post]()
    
    init(interactor: PostsInteractorInput, router: PostsRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension PostsPresenter: PostsModuleInput {
    
}

//MARK: - TextEditModuleOutput

extension PostsPresenter: TextEditModuleOutput {
    func textChanged(_ text: String?) {
        view?.setText(text)
    }
}

//MARK: - PostModuleOutput

extension PostsPresenter: PostModuleOutput {
    func postChanged(_ post: Post) {
        view?.setChangedPost(post)
    }
}

//MARK: - View output

extension PostsPresenter: PostsViewOutput {
    func viewIsReady() {
        view?.setupInitialState()
        view?.setupDisplayManager()
        view?.startIndication()
        interactor.loadData()
    }
    
    func viewAppearing() {
        
    }
    
    func editSomeText(_ text: String?) {
        router.openEditText(withOutput: self, text: text)
    }
    
    func postSelected(post: Post) {
        print("Selected post is: \(post)")
        router.openPost(withOutput: self, post: post)
    }
    
    func refreshPosts() {
        isRefreshing = true
        interactor.loadData()
    }
    
    func deletePost(_ post: Post) {
        interactor.deletePost(post)
    }
    
    func logout() {
        interactor.logout()
        router.openLogin()
    }
}

//MARK: - Interactor output

extension PostsPresenter: PostsInteractorOutput {
    func encounteredError(error: Error) {
        view?.stopIndication()
        view?.showError(message: error.message())
    }
    
    func postsLoaded(_ posts: [Post]) {
        if isRefreshing {
            view?.stopRefreshing()
            isRefreshing = false
        } else {
            view?.stopIndication()
        }
        view?.setupCreatePostBtn(posts.count != 100)
        self.posts = posts
        view?.setItems(posts)
    }
    
    func postDeleted(_ post: Post) {
        let postsCopy = posts
        var i = 0
        for p in postsCopy {
            if p.id == post.id {
                posts.remove(at: i)
                view?.setItems(posts)
                view?.setupCreatePostBtn(posts.count < 100)
                return
            }
            i += 1
        }
    }
}
