//
//  PostsMocks.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

@testable import ViperKitExample
import ViperKit
import Dip
import UIKit
import Dip_UI

// MARK: - Assemblies mock

class MockPostsAssembliesFactory: AssembliesFactory {
    override func registerServicesLayer(root: RootServicesAssembly) {
        container.register(.eagerSingleton) { MockServicesAssembly(withCollaborator: $0) }
    }
    override func registerPresentationLayer(root: RootViperAssembly) {
        container.register(.eagerSingleton) { MockPostsModuleAssembly(withCollaborator: $0) }
    }
}

class MockPostsModuleAssembly: BaseViperAssembly {
    let tag: String? = nil
    
    override init(withCollaborator collaborator: RootViperAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(tag: nil) { MockPostsViewController() }
            .implements(PostsViewInput.self, SegueHandler.self)
            .resolvingProperties { (container, controller) in
                controller.output = try container.resolve()
                controller.moduleInput = try container.resolve() as PostsModuleInput
        }
        
        container.register { MockPostsPresenter(interactor: $0, router: $1) }
            .implements(PostsModuleInput.self, PostsViewOutput.self, PostsInteractorOutput.self)
            .resolvingProperties { [unowned self] (container, presenter) in
                presenter.view = try container.resolve(tag: self.tag)
        }
        
        container.register { MockPostsRouter() }
            .implements(PostsRouterInput.self)
            .resolvingProperties { [unowned self] (container, router) in
                router.segueHandler = try container.resolve(tag: self.tag)
        }
        
        container.register { MockPostsInteractor(postService: $0, authService: $1) }
            .implements(PostsInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
        }
    }
}

extension MockPostsViewController: StoryboardInstantiatable {}

// MARK: - Posts View Controller Mock

class MockPostsViewController: MockBaseViewController {
    var output: PostsViewOutput!
    var moduleInput: ModuleInput!
    
    var someTextLbl: UILabel!
    var tableView: UITableView!
    var createPostBtn: UIBarButtonItem!
    
    var displayManager: MockPostsDisplayManager! {
        didSet {
            didSetDisplayManager = displayManager != nil
        }
    }
    
    var setupDisplayManagerCalled = false
    var setupCreatePostBtnCalled = false
    var setItemsCalled = false
    var setTextCalled = false
    var setChangedPostCalled = false
    var stopRefreshingCalled = false
    
    var setupInitialStateCalled = false
    
    var postSelectedCalled = false
    var deletePostCalled = false
    
    var didSetDisplayManager = false}

extension MockPostsViewController: PostsViewInput {
    func setupDisplayManager() {
        setupDisplayManagerCalled = true
    }
    
    func setupCreatePostBtn(_ state: Bool) {
        setupCreatePostBtnCalled = true
    }
    
    func setItems(_ items: [Post]) {
        setItemsCalled = true
    }
    
    func setText(_ text: String?) {
        setTextCalled = true
    }
    
    func setChangedPost(_ post: Post) {
        setChangedPostCalled = true
    }
    
    func stopRefreshing() {
        stopRefreshingCalled = true
    }
    
    func setupInitialState() {
        setupInitialStateCalled = true
    }
}

extension MockPostsViewController: PostsDisplayManagerDelegate {
    func postSelected(post: Post) {
        postSelectedCalled = true
    }
    
    func deletePost(_ post: Post) {
        deletePostCalled = true
    }
}

// MARK: - Posts Display Manager Mock

class MockPostsDisplayManager: PostsDisplayManager {
    var itemsDidSet = false
    var setChangedPostCalled = false
    var deletePostCalled = false
    
    var didSetDelegate = false
    
    override var delegate: PostsDisplayManagerDelegate? {
        didSet {
            didSetDelegate = delegate != nil
        }
    }
    
    override var items: [Post] {
        didSet {
            itemsDidSet = true
        }
    }
    
    override func setChangedPost(_ post: Post) {
        setChangedPostCalled = true
    }
}

// MARK: - Posts Table View Cell Mock

class MockPostsTableViewCell: PostsTableViewCell {
    var itemDidSet = false
    
    override func setPost(_ post: Post) {
        itemDidSet = true
    }
}

// MARK: - Posts Presenter Mock

class MockPostsPresenter {
    weak var view: PostsViewInput?
    let interactor: PostsInteractorInput
    let router: PostsRouterInput
    
    var isRefreshing = false
    var posts: [Post] = [Post]() {
        didSet {
            postsDidSet = true
        }
    }
    
    var viewIsReadyCalled = false
    var viewAppearingCalled = false
    var editSomeTextCalled = false
    var postSelectedCalled = false
    var refreshPostsCalled = false
    var deletePostCalled = false
    var logoutCalled = false
    var postsLoadedCalled = false
    var postDeletedCalled = false
    var encounteredErrorCalled = false
    var postChangedCalled = false
    var textChangedCalled = false
    var postsDidSet = false
    
    init(interactor: PostsInteractorInput, router: PostsRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension MockPostsPresenter: PostsModuleInput {}

extension MockPostsPresenter: PostsViewOutput {
    func viewIsReady() {
        viewIsReadyCalled = true
    }
    
    func viewAppearing() {
        viewAppearingCalled = true
    }
    
    func editSomeText(_ text: String?) {
        editSomeTextCalled = true
    }
    
    func postSelected(post: Post) {
        postSelectedCalled = true
    }
    
    func refreshPosts() {
        refreshPostsCalled = true
    }
    
    func deletePost(_ post: Post) {
        deletePostCalled = true
    }
    
    func logout() {
        logoutCalled = true
    }
}

extension MockPostsPresenter: PostsInteractorOutput {
    func postsLoaded(_ posts: [Post]) {
        postsLoadedCalled = true
    }
    
    func postDeleted(_ post: Post) {
        postDeletedCalled = true
    }
    
    func encounteredError(error: Error) {
        encounteredErrorCalled = true
    }
}

extension MockPostsPresenter: PostModuleOutput {
    func postChanged(_ post: Post) {
        postChangedCalled = true
    }
}

extension MockPostsPresenter: TextEditModuleOutput {
    func textChanged(_ text: String?) {
        textChangedCalled = true
    }
}

// MARK: - Posts Router Mock

class MockPostsRouter: PostsRouterInput {
    weak var segueHandler: SegueHandler?
    
    var openEditTextCalled = false
    var openLoginCalled = false
    var openPostCalled = false
    
    func openEditText(withOutput output: TextEditModuleOutput, text: String?) {
        openEditTextCalled = true
    }
    
    func openLogin() {
        openLoginCalled = true
    }
    
    func openPost(withOutput output: PostModuleOutput, post: Post) {
        openPostCalled = true
    }
}

// MARK: - Posts Interactor Mock

class MockPostsInteractor: PostsInteractorInput {
    weak var output: PostsInteractorOutput?
    
    var loadDataCalled = false
    var deletePostCalled = false
    var logoutCalled = false
    
    let authService: AuthorizationServiceType!
    let postService: PostServiceType!
    
    init(postService: PostServiceType, authService: AuthorizationServiceType) {
        self.postService = postService
        self.authService = authService
    }
    
    func loadData() {
        loadDataCalled = true
    }
    
    func deletePost(_ post: Post) {
        deletePostCalled = true
    }
    
    func logout() {
        logoutCalled = true
    }
}
