//
//  SearchPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 17/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class SearchPresenter {
    weak var view: SearchViewInput?
    let interactor: SearchInteractorInput
    let router: SearchRouterInput
    
    init(interactor: SearchInteractorInput, router: SearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension SearchPresenter: SearchModuleInput {
    
}

//MARK: - PostModuleOutput

extension SearchPresenter: PostModuleOutput {
    func postChanged(_ post: Post) {
        view?.setChangedPost(post)
    }
}

//MARK: - View output

extension SearchPresenter: SearchViewOutput {
    func viewIsReady() {
        view?.setupInitialState()
    }
    
    func postSelected(_ post: Post) {
        router.openPost(withOutput: self, post: post)
    }
    
    func search(_ keyword: String?) {
        guard
            let keyword = keyword,
            let id = Int(keyword)
        else {
            view?.showError(message: "Enter ID in search field")
            return
        }
        
        view?.startIndication()
        interactor.getPosts(byUserID: id)
    }
    
    func cancelSearch() {
        view?.setPosts([Post]())
    }
}

//MARK: - Interactor output

extension SearchPresenter: SearchInteractorOutput {
    func postsLoaded(_ posts: [Post]) {
        view?.stopIndication()
        view?.setPosts(posts)
    }
    
    func encounteredError(error: Error) {
        view?.stopIndication()
        view?.showError(message: error.message())
    }
}
