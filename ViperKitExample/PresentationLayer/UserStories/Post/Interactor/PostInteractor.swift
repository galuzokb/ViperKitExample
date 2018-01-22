//
//  PostPostInteractor.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import ViperKit
import PromiseKit

class PostInteractor: PostInteractorInput {
    weak var output: PostInteractorOutput?
    
    //MARK: - Services
    let postService: PostServiceType!
    
    init(postService: PostServiceType) {
        self.postService = postService
    }
    
    func changePost(_ id: Int, title: String?, body: String?) {
        if let title = title, let body = body {
            firstly {
                self.postService.changePostTitleAndBody(id, title: title, body: body)
            }.then { _ in
                self.output?.postChanged(withTitle: title, withBody: body)
            }.catch { error in
                self.output?.encounteredError(error: error)
            }
        } else if let title = title {
            firstly {
                self.postService.changePostTitle(id, title: title)
            }.then { _ in
                self.output?.postChanged(withTitle: title, withBody: nil)
            }.catch { error in
                self.output?.encounteredError(error: error)
            }
        } else if let body = body {
            firstly {
                self.postService.changePostBody(id, body: body)
            }.then { _ in
                self.output?.postChanged(withTitle: nil, withBody: body)
            }.catch { error in
                self.output?.encounteredError(error: error)
            }
        }
    }
}
