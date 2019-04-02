//
//  PostsViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 12/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class PostsViewController: ViperKitExampleBaseViewController {
    var output: PostsViewOutput!
    var moduleInput: ModuleInput!
    
    var displayManager: PostsDisplayManager!
    
    // MARK: Outlets
    
    @IBOutlet weak var someTextLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createPostBtn: UIBarButtonItem!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewAppearing()
    }
    
    // MARK: IBActions
    @IBAction func editSomeText(_ sender: UIButton) {
        output.editSomeText(someTextLbl.text)
    }
    
    @IBAction func createPost(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        output.logout()
    }
    
    @objc func refreshPosts() {
        output.refreshPosts()
    }
}

// MARK: - View Input

extension PostsViewController: PostsViewInput {
    
    func setupInitialState() {
        self.view.gestureRecognizers?.removeLast()
        someTextLbl.text = "Old Text Here"
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        tableView.refreshControl?.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Fetching Posts ...", attributes: [:])
        tableView.refreshControl?.accessibilityLabel = "Posts Table View Refresh Control"
    }
    
    func setupDisplayManager() {
        displayManager = PostsDisplayManager(tableView: tableView)
        displayManager.delegate = self
    }
    
    func setupCreatePostBtn(_ state: Bool) {
        createPostBtn.isEnabled = state
    }
    
    func setItems(_ items: [Post]) {
        displayManager.items = items
    }
    
    func setText(_ text: String?) {
        someTextLbl.text = text
    }
    
    func setChangedPost(_ post: Post) {
        displayManager.setChangedPost(post)
    }
    
    func stopRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: - Module Input

extension PostsViewController: ModuleInputProvider {}

extension PostsViewController: PostsDisplayManagerDelegate {
    func postSelected(post: Post) {
        output.postSelected(post: post)
    }
    
    func deletePost(_ post: Post) {
        output.deletePost(post)
    }
}
