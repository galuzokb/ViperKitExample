//
//  PostsTableViewCell.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import UIKit

protocol PostsTableViewCellDelegate: class {
    func deletePost(_ post: Post)
}

class PostsTableViewCell: UITableViewCell {
    
    weak var delegate: PostsTableViewCellDelegate?
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    var item: Post? {
        didSet {
            if let item = item {
                idLbl.text = item.id.description
                titleLbl.text = item.title
            } else {
                idLbl.text = nil
                titleLbl.text = nil
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
        delegate = nil
    }
    
    @IBAction func deletePost(_ sender: UIButton) {
        if let post = item {
            delegate?.deletePost(post)
        }
    }
}
