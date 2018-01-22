//
//  NetworkType.swift
//  ViperKitExample
//
//  Created by Kirill Galuzo on 1/15/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit
import Alamofire

enum Method: String {
    case GET, POST, PUT, PATCH, DELETE
}

protocol NetworkType {
    
    func setDefaultHeader(key: String, value: String)
    func removeDefaultHeader(key: String)
    
    func request(method: Method, url: String) -> Promise<Data>
    func request(method: Method, url: String, json: [String: Any]?) -> Promise<Data>
    
    func setRetrier(retrier: RequestRetrier)
    
    func upload(url: String, data: Data) -> Promise<Void>
}
