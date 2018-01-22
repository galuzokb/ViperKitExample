//
//  TextEditTextEditViewController.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 16/01/2018.
//  Copyright © 2018 galuzokb@gmail.com. All rights reserved.
//

import Foundation
import UIKit
import ViperKit

class TextEditViewController: BaseViewController {
    var output: TextEditViewOutput!
    var moduleInput: ModuleInput!
    
    // MARK: Outlets
    
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: IBActions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        output.cancel()
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        output.done(textView.text)
    }
}

// MARK: - View Input

extension TextEditViewController: TextEditViewInput {
    func setText(_ text: String?) {
        textView.text = text ?? ""
    }
}

// MARK: - Module Input

extension TextEditViewController: ModuleInputProvider {}

extension TextEditViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        dismissKeyboard()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
