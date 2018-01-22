//
//  main.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/10/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ViperKit

class ViperKitExampleApplication: Application {
    override class var factory: AssembliesFactory {
        return ViperKitExampleAssembliesFactory()
    }
}

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(
        to: UnsafeMutablePointer<Int8>.self,
        capacity: Int(CommandLine.argc)
    ),
    NSStringFromClass(ViperKitExampleApplication.self),
    NSStringFromClass(AppDelegate.self)
)


