//
//  ViperKitExampleAssembliesFactory.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/8/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ViperKit

class ViperKitExampleAssembliesFactory: AssembliesFactory {
    
    override func registerLaunchLayer(root: RootLaunchAssembly) {
        container.register(.eagerSingleton) { AppDelegatesAssembly(withCollaborator: $0) }
    }
    
    override func registerCoreLayer(root: RootCoreAssembly) {
        container.register(.eagerSingleton) { ToolsAssembly(withRoot: $0) }
        container.register(.eagerSingleton) { SystemAssembly(withRoot: $0) }
        container.register(.eagerSingleton) { StoryboardAssembly(withRoot: $0, system: $1) }
    }

    override func registerServicesLayer(root: RootServicesAssembly) {
        container.register(.eagerSingleton) { RepositoriesAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { ServicesAssembly(withCollaborator: $0) }
    }
    
    override func registerPresentationLayer(root: RootViperAssembly) {
        container.register(.eagerSingleton) { SplashModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { SigninModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { PostsModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { TextEditModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { PostModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { CreatePostModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { SearchModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { SegmentControlTestModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { FirstModuleAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { SecondModuleAssembly(withCollaborator: $0) }
    }
}

