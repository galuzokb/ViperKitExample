//
//  PostsDisplayManager.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import UIKit

protocol PostsDisplayManagerDelegate: class {
    func postSelected(post: Post)
    func deletePost(_ post: Post)
}

class PostsDisplayManager: NSObject {
    
    var tableView: UITableView!
    
    weak var delegate: PostsDisplayManagerDelegate?
    
    var items = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func setChangedPost(_ post: Post) {
        var i = 0
//        let itemsCopy = items
        for item in items {
            if item.id == post.id {
                items[i] = post
                tableView.reloadRows(at: [IndexPath(item: i, section: 0)], with: .automatic)
                return
            }
            i += 1
        }
    }
}

extension PostsDisplayManager: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count != 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell") as? PostsTableViewCell else {
            fatalError("Can't dequeue reusable cell with id \"PostsCell\"")
        }
        cell.setPost(items[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("adadadadasdasdad")
        tableView.deselectRow(at: indexPath, animated: true)
        if items.count > indexPath.row {
            delegate?.postSelected(post: items[indexPath.row])
        }
    }
}

extension PostsDisplayManager: PostsTableViewCellDelegate {
    func deletePost(_ post: Post) {
        delegate?.deletePost(post)
    }
}
