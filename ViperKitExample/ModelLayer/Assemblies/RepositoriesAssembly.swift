//
//  RepositoriesAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/16/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

class RepositoriesAssembly: BaseServiceAssembly {
    
    override init(withCollaborator collaborator: RootServicesAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(.singleton) { TestRepository(mapping: $0, network: $1) as TestRepositoryType }
        container.register(.singleton) { PostRepository(mapping: $0, network: $1) as PostRepositoryType }
        
        bootstrap()
    }
}
