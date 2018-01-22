//
//  PostPostViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class PostViewController: BaseViewController {
    var output: PostViewOutput!
    var moduleInput: ModuleInput!
    
    // MARK: Outlets
    
    @IBOutlet weak var postIDLbl: UILabel!
    @IBOutlet weak var userIDLbl: UILabel!
    @IBOutlet weak var titleTV: UITextView!
    @IBOutlet weak var bodyTV: UITextView!
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: IBActions
    @IBAction func done(_ sender: UIBarButtonItem) {
        output.done(title: titleTV.text, body: bodyTV.text)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        output.back()
    }
}

// MARK: - View Input

extension PostViewController: PostViewInput {
    func setupInitialState() {
        doneBtn.isEnabled = false
    }
    
    func setupPost(_ post: Post) {
        postIDLbl.text = post.id.description
        if let userID = post.userID { userIDLbl.text = userID.description } else { userIDLbl.text = nil }
        if let title = post.title { titleTV.text = title } else { titleTV.text = "" }
        if let body = post.body { bodyTV.text = body } else { bodyTV.text = "" }
    }
    
    func setDoneBtnState(_ isEnabled: Bool) {
        doneBtn.isEnabled = isEnabled
    }
}

// MARK: - Module Input

extension PostViewController: ModuleInputProvider {}

extension PostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == titleTV { output.titleDidChange(textView.text) }
        if textView == bodyTV { output.bodyDidChange(textView.text) }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
