//
//  HTTPErrorParserType.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation

protocol HTTPErrorParserType {
    func parseHTTPError(error: Error) -> Error
}
