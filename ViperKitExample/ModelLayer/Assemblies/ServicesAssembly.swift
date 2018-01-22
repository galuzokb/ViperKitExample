//
//  ServicesAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/11/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import ViperKit

class ServicesAssembly: BaseServiceAssembly {
    override init(withCollaborator collaborator: RootServicesAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(.singleton) { AuthorizationService() as AuthorizationServiceType }
        container.register(.singleton) { TestService(repository: $0) as TestServiceType }
        container.register(.singleton) { PostService(postRepo: $0) as PostServiceType }
        
        bootstrap()
    }
}
