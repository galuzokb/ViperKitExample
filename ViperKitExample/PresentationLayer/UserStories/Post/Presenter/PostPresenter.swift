//
//  PostPostPresenter.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

class PostPresenter {
    weak var view: PostViewInput?
    let interactor: PostInteractorInput
    let router: PostRouterInput
    
    weak var output: PostModuleOutput?
    
    var post: Post? = nil
    
    init(interactor: PostInteractorInput, router: PostRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Module Input

extension PostPresenter: PostModuleInput {
    func setPost(_ post: Post?) {
        self.post = post
    }
    
    func setOutput(_ output: PostModuleOutput) {
        self.output = output
    }
}

//MARK: - View output

extension PostPresenter: PostViewOutput {
    func viewIsReady() {
        view?.setupInitialState()
        if let post = post {
            view?.setupPost(post)
        } else {
            view?.showError(message: "There is no post")
            router.close()
        }
    }
    
    func titleDidChange(_ title: String) {
        guard let post = post else { return }
        if let postTitle = post.title {
            if postTitle == title {
                return
            }
        }
        view?.setDoneBtnState(true)
    }
    
    func bodyDidChange(_ body: String) {
        guard let post = post else { return }
        if let postBody = post.body {
            if postBody == body {
                return
            }
        }
        view?.setDoneBtnState(true)
    }
    
    func done(title: String?, body: String?) {
        guard let post = post else {
            router.close()
            return
        }
        interactor.changePost(post.id, title: title, body: body)
    }
    
    func back() {
        router.close()
    }
}

//MARK: - Interactor output

extension PostPresenter: PostInteractorOutput {
    func postChanged(withTitle title: String? = nil, withBody body: String? = nil) {
        view?.stopIndication()
        view?.setDoneBtnState(false)
        if let title = title { self.post?.title = title }
        if let body = body { self.post?.body = body }
        if let post = self.post {
            output?.postChanged(post)
        }
        router.close()
    }
    
    func encounteredError(error: Error) {
        view?.stopIndication()
        view?.showError(message: error.message())
    }
    
    
}
