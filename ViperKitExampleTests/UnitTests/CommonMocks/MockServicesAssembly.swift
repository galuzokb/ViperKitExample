//
//  MockServicesAssembly.swift
//  ViperKitExampleTests
//
//  Created by Kirill Galuzo on 7/2/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

@testable import ViperKitExample
import ViperKit
import Dip
import UIKit
import Dip_UI

class MockServicesAssembly: BaseServiceAssembly {
    override init(withCollaborator collaborator: RootServicesAssembly) {
        super.init(withCollaborator: collaborator)
        
        container.register(.singleton) { MockAuthorizationService() as AuthorizationServiceType }
        container.register(.singleton) { MockPostService() as PostServiceType }
        
        bootstrap()
    }
}
