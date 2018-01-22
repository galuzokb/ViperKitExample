//
//  Error.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ObjectMapper

protocol BaseError: CustomNSError {
    
}

extension BaseError {
    static var errorDomain: String {
        return String(describing: type(of: self))
    }
    
    var errorCode: Int {
        return String(reflecting: self).hashValue
    }
}

class ErrorResponse: BaseError, Mappable {
    var code: Constants.ErrorCode = .none
    
    var message = "Unknown error"
    
    var status = 0
    
    init(code: Constants.ErrorCode = .none, status: Int = 0, message: String = "Try again") {
        self.code = code
        self.status = status
        self.message = message
    }
    
    init() {}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        status  <- map["status"]
        code    <- map["code"]
        message <- map["message"]
    }
}

protocol PrintableError: BaseError {
    func message() -> String
}

enum BackendError: BaseError {
    case badStatusWithData(Data)
    case badStatusWithStatusCode(Int)
    case badStatus
    case unauthorised
    case unconvertableData
}

extension Error {
    func message() -> String {
        if let error = self as? ErrorResponse {
            return error.message
        }
        if let custom = self as? CustomError {
            return custom.message()
        }
        if let error = self as? PrintableError {
            return error.message()
        }
        
        return "Unknown error"
    }
}

struct TextualError: PrintableError {
    var msg: String
    
    func message() -> String {
        return msg
    }
}

struct CustomError: Error {
    var message: String = ""
    
    init(message: String) {
        self.message = message
    }
}
