//
//  KeyboardLayoutConstaint.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/18/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import UIKit

class KeyboardLayoutConstraint: NSLayoutConstraint {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShowNotification(_ notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo else {return}
        
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.constant = keyboardFrame.size.height
        layoutIfNeededWithAnimation()
    }
    
    @objc func keyboardWillHideNotification(_ notification: Notification) {
        self.constant = 0
        layoutIfNeededWithAnimation()
    }
    
    func layoutIfNeededWithAnimation() {
        UIApplication.shared.keyWindow?.layoutIfNeeded()
    }
    
}
