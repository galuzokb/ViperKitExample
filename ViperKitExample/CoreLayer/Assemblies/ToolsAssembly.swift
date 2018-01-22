//
//  ToolsAssembly.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ViperKit
import Alamofire

class ToolsAssembly: BaseCoreAssembly {
    override init(withRoot collaborator: RootCoreAssembly) {
        super.init(withRoot: collaborator)
        
        container.register(.eagerSingleton) { SessionManager.default }
        container.register(.eagerSingleton) { Mapping() as MappingType }
        container.register(.eagerSingleton) { HTTPErrorParser() as HTTPErrorParserType }
        container.register(.eagerSingleton) { Network(httpErrorParser: $0) as NetworkType }
    }
}
