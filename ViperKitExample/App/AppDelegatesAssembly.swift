//
//  AppDelegatesAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ViperKit

class AppDelegatesAssembly: BaseLaunchAssembly {
    override init(withCollaborator collaborator: RootLaunchAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register { AppDelegate() }
    }
}
