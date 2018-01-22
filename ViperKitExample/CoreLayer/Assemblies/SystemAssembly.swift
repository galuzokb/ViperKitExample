//
//  SystemAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ViperKit
import UIKit

class SystemAssembly: BaseCoreAssembly {
    var window: UIWindow {
        return resolve()
    }
    
    var bundle: Bundle {
        return resolve()
    }
    
    override init(withRoot collaborator: RootCoreAssembly) {
        super.init(withRoot: collaborator)
        
        container.register(.eagerSingleton) { UIWindow(frame: UIScreen.main.bounds) }
        container.register(.eagerSingleton) { Bundle.main }
        container.register(.eagerSingleton) { UserDefaults.standard }
    }
}

