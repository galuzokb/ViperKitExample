//
//  ViperKitExamplePKHUD.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 6/21/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import PKHUD

class MyHUD: PKHUDSquareBaseView, PKHUDAnimating {
    public func startAnimation() {
        imageView.layer.add(PKHUDAnimation.discreteRotation, forKey: "progressAnimation")
    }
    
    public func stopAnimation() {
    }
    
    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(image: #imageLiteral(resourceName: "activity"), title: title, subtitle: subtitle)
        self.accessibilityLabel = "PKHUD Progress View"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.accessibilityLabel = "PKHUD Progress View"
    }
}
