//
//  SearchTableViewCell.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/19/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var item: Post? {
        didSet{
            if let item = item {
                idLbl.text = item.id.description
                titleLbl.text = item.title
            } else {
                idLbl.text = nil
                titleLbl.text = nil
            }
        }
    }
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
    }
}
