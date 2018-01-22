//
//  SearchDisplayManager.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/19/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import UIKit

protocol SearchDisplayManagerDelegate: class {
    func postSelected(_ post: Post)
}

class SearchDisplayManager: NSObject {
    
    fileprivate var tableView: UITableView!
    
    fileprivate var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: SearchDisplayManagerDelegate?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func setPosts(_ posts: [Post]) {
        self.posts = posts
    }
    
    func setChangedPost(_ post: Post) {
        var i = 0
        for p in posts {
            if p.id == post.id {
                posts[i] = post
                tableView.reloadRows(at: [IndexPath(item: i, section: 0)], with: .automatic)
                return
            }
            i += 1
        }
    }
}

extension SearchDisplayManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as? SearchTableViewCell else {
            fatalError("Can't dequeue reusable cell with id \"searchCell\"")
        }
        cell.item = posts[indexPath.row]
        return cell
    }
}

extension SearchDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if posts.count > indexPath.row {
            delegate?.postSelected(posts[indexPath.row])
        }
    }
}
