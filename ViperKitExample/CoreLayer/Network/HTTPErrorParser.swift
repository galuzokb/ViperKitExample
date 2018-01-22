//
//  HTTPErrorParser.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ObjectMapper

class HTTPErrorParser: HTTPErrorParserType {
    
    func parseHTTPError(error: Error) -> Error {
        
        if let error = error as? BackendError {
            switch error {
            case .badStatusWithData(let data) where data.count > 0:
                print("parsehtteerror")
                print(String(data: data, encoding: String.Encoding.utf8) ?? "")
                let err = Mapper<ErrorResponse>().map(JSONString: String(data: data, encoding: String.Encoding.utf8) ?? "")
                return err ?? error
            case .badStatusWithStatusCode(let status):
                return ErrorResponse(status: status)
            case .badStatusWithData(let data) where data.count == 0:
                return TextualError(msg: "Check your internet connection")
            default:
                return error
            }
        }
        return error
    }
}
